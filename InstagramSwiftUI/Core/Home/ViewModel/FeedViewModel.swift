//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by kashee on 29/03/24.
//

import Foundation
import Firebase
import FirebaseDatabase


@MainActor
class FeedViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published var user: User?
    
    init() {
        Task {
            await fetchUser()
        }
    }
    
    func fetchUser() async {
        // MARK: - This is when using realtime database and same approach you can use in authViewModel
        guard let uid = Auth.auth().currentUser?.uid else { return }
        do {
            self.user = try await Database.fetchUserWithUID(uid: uid)
            await fetchAllPost(user: self.user)
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
        }
    }
    
    func fetchAllPost(user: User?) async {
        guard let user = user else { return }
        do {
            let snapshot = try await Database.database().reference().child("posts").child(user.uid).getData()
            if snapshot.value != nil {
                guard let dictionaries = snapshot.value as? [String: Any] else { return }
                var posts = [Post]()
                dictionaries.forEach { (key, value) in
                    guard let dictionary = value as? [String: Any] else { return }
                    posts.append(Post(user: user, dictionary: dictionary))
                }
                self.posts = posts
            }
        } catch {
            print("DEBUG: Failed to fetch posts: \(error.localizedDescription)")
        }
    }
}
