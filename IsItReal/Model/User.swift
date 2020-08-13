//
//  User.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 12/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

struct User: Decodable {
    let name: String
    let idStr: String
    let description: String
    let profileImage: String
    let protected: Bool
    let verified: Bool
    let screenName: String
    let followersCount: Float
    let createdDate: String
    let friendsCount: Float
}

extension User {
    enum CodingKeys: String, CodingKey {
        case name, description, protected, verified
        case idStr          = "id_str"
        case profileImage   = "profile_image_url_https"
        case friendsCount   = "friends_count"
        case followersCount = "followers_count"
        case screenName     = "screen_name"
        case createdDate    = "created_at"
    }
}
