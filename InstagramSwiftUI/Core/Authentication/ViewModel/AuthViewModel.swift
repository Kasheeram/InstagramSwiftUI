//
//  AuthViewModel.swift
//  InstagramSwiftUI
//
//  Created by kashee on 17/03/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        print("Create account...")
        
        // MARK: - This is when storing user info on firestore
        //        do {
        //            let result = try await Auth.auth().createUser(withEmail: email, password: password)
        //            self.userSession = result.user
        //            let user = User(id: result.user.uid, email: email, fullname: fullname)
        //            let encodedUser = try Firestore.Encoder().encode(user)
        //            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        //            await fetchUser()
        //        } catch {
        //            print("DEBUG: failed to create user with error: \(error.localizedDescription)")
        //        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Faild to sig nout with error: \(error)")
        }
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        // MARK: - This is when using realtime database
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Database.database().reference().child("users").child(uid).getData() else { return }
        if (snapshot.value != nil) {
            guard let userdictionary = snapshot.value as? [String: Any] else { return }
            self.currentUser = User(uid: uid, dictionary: userdictionary)
        } else {
            print("Failed to fetch user for posts")
        }
        
        // MARK: - This when using firestore
        //        guard let uid = Auth.auth().currentUser?.uid else { return }
        //        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        //        self.currentUser = try? snapshot.data(as: User.self)
        //        print("DEBUG: Current user is :\(self.currentUser)")
    }
}
