//
//  User.swift
//  InstagramSwiftUI
//
//  Created by kashee on 29/03/24.
//

import Foundation

//struct User: Identifiable, Codable {
//    let id: String
//    let email: String
//    let fullname: String
//}

struct User: Identifiable {
    var id: String { uid }
    let uid: String
    let username: String
    let profileImgeUrl: String
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImgeUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
