//
//  MockRepository.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

// Breaking Laws for a good reason :x
class MockRepository: TweetRepository {
    
    override func getAll() -> [Tweet] {
        if let data = retrivedDataFromBundle(filename: "MockTweets") {
            if let tweets = try? JSONDecoder().decode([Tweet].self, from: data) {
                self.tweets = tweets
            }
        }
        return tweets
    }
    
    override func delete(object: Tweet) -> Bool {
        return false
    }
    
    private func retrivedDataFromBundle(filename: String) -> Data? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try? Data(contentsOf: url)
                return data
            }
        }
        return nil
    }
}
