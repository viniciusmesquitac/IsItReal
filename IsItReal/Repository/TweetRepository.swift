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
    
    let helper = FileHelper()
    
    var tweets: [Tweet] = []
    
    func getAll() -> [Tweet] {
        // TODO: Get all files decoded to tweet
        let fileNames: [String] = helper.contentsForDirectory(atPath: "")
        
        guard tweets.isEmpty else {
            return tweets
        }
        
        self.tweets = fileNames.compactMap { fileName in
            if let data = helper.retrieveFile(at: fileName) {
                // decode from Data type to Item type
                let item = try? JSONDecoder().decode(Tweet.self, from: data)
                return item
            }
            return nil
        }
        
        return tweets
    }
    
    func get(id: Int) -> Tweet? {
        // TODO:
        return nil
    }
    
    func add(object: Tweet) -> Bool {
        // TODO:
        if let data = try? JSONEncoder().encode(object) {
            helper.createFile(with: data, name: object.idStr)
            return true
        }
        return false
    }
    
    func update(object: Tweet) -> Bool {
        // TODO:
        return false
    }
    
    func delete(object: Tweet) -> Bool {
        // TODO:
        return false
    }
    
    
    
}
