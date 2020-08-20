//
//  QueryResult.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 17/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

struct QueryResult {
    let textTweet: String?
    let query: String?
    let user: String?
    let keySearch: [String.SubSequence]?
}
