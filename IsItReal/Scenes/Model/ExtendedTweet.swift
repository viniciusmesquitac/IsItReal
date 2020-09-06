//
//  CompletedTweet.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 05/09/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

struct ExtendedTweet: Codable {
    let fullText: String

    enum CodingKeys: String, CodingKey {
        case fullText = "full_text"
    }
}
