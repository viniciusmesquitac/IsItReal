//
//  Tweet.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 12/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

struct Tweet: Decodable & Encodable {
    let text: String
    let idStr: String
    let createdDate: String
    let user: User
}

extension Tweet {
    enum CodingKeys: String, CodingKey {
        case text, user
        case idStr       = "id_str"
        case createdDate = "created_at"
    }
}
