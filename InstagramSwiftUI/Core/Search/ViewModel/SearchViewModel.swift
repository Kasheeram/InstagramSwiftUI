//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by kashee on 07/04/24.
//

import Foundation
import Firebase
import FirebaseDatabase


@MainActor
class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task {
            await fetchUsers()
        }
    }
    
    func fetchUsers() async {
        
        let snapshot = try? await Database.database().reference().child("users").getData()
        guard let dictionaries = snapshot?.value as? [String: Any] else { return }
        dictionaries.forEach { (key, value) in
            if key == Auth.auth().currentUser?.uid {
                print("Found myself, omit from list")
                return
            }
            guard let userDisctionary = value as? [String: Any] else { return }
            let user = User(uid: key, dictionary: userDisctionary)
            self.users.append(user)
            self.users.sort { u1, u2 in
                return u1.username.compare(u2.username) == .orderedAscending
            }
        }
    }
    
    
}
