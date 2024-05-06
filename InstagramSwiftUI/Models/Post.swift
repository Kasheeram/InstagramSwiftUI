//
//  Post.swift
//  InstagramSwiftUI
//
//  Created by kashee on 29/03/24.
//

import Foundation

struct Post: Identifiable {
    var id: String
    let user: User
    let imageUrl: String
    let caption: String
    
    var hasLiked = false
    
    let creationDate: Date
    init(user: User, dictionary: [String: Any]) {
        self.id = UUID().uuidString
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
