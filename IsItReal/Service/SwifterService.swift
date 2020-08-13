//
//  SwifterService.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Swifter

class SwifterService {
    
    public static let shared = SwifterService()
    
    private init() {}
    
    private var swifter = Swifter(
        consumerKey: KEY,
        consumerSecret: SECRET)
    
    public var failureHandler: (Error) -> Void = { _ in }
    
    public func searchTweet(query: String, completion: @escaping ([Tweet]?) -> Void) {
        
        swifter.searchTweet(using: query, success: { json, _ in
            if let jsonString = json.array?.description {
                let jsonData = Data(jsonString.utf8)
                let tweets = self.decodeTweets(from: jsonData)
                completion(tweets)
            }
        }, failure: failureHandler)
        
    }
    
    private func decodeTweets(from data: Data) -> [Tweet]? {
        let decoder = JSONDecoder()
        guard let tweets = try? decoder.decode([Tweet].self, from: data) else {
            return nil
        }
        return tweets
    }
}

enum AuthSwifter {
    static let url: URL? = URL(string: "TwitterTestingAPI://success")
}
