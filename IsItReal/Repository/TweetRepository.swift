//
//  TweetRepository.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

class TweetRepository: Repository {
    
    typealias Object = Tweet
    
    let fileManagerHelper = FileManagerHelper()
    
    func getAll() -> [Tweet] {
        // TODO:
        return []
    }
    
    func get(id: Int) -> Tweet? {
        // TODO:
        return nil
    }
    
    func add(object: Tweet) {
        // TODO:
    }
    
    func update(object: Tweet) {
        // TODO:
    }
    
    func delete(object: Tweet) {
        // TODO:
    }
    
    
    
}
