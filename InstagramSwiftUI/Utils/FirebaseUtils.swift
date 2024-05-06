//
//  FirebaseUtils.swift
//  InstagramSwiftUI
//
//  Created by kashee on 31/03/24.
//

import Foundation
import FirebaseDatabase

extension Database {
    static func fetchUserWithUID(uid: String) async throws -> User {
        // MARK: - This is when using realtime database
        guard let snapshot = try? await Database.database().reference().child("users").child(uid).getData() else { throw ErrorCases.invalidUrl }
        if (snapshot.value != nil) {
            guard let userdictionary = snapshot.value as? [String: Any] else { throw ErrorCases.invalidResponse }
            let user = User(uid: uid, dictionary: userdictionary)
            return user
        } else {
            print("Failed to fetch user for posts")
            throw ErrorCases.invalidResponse
        }
    }
}
