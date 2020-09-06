//
//  SwifterService.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Swifter

enum AuthSwifter {
    static let url: URL! = URL(string: "TwitterTestingAPI://success")
}

class APITwitter {
    
    public static let shared = APITwitter()
    
    private init() {}
    
    private var swifter = Swifter(consumerKey: KEY, consumerSecret: CONSUMER_SECRET,
                                  oauthToken: TOKEN,
                                  oauthTokenSecret: SECRET)
    
    public var failureHandler: ((Error) -> Void) = { error in
        print(error)
    }
    
    public func searchCompactTweet(query: String, completion: @escaping ([Tweet]?) -> Void) {
        self.swifter.searchTweet(using: query, count: 100, tweetMode: .compat, success: { json, _ in
            if let data = self.parseArrayJsonToData(json) {
                completion(self.decodeTweets(from: data))
            }
        }, failure: self.failureHandler)
    }
    
    public func getLatest(screenName: String, completion: @escaping ([Tweet]?) -> Void) {
        let userTag = UserTag.screenName(screenName)
        self.swifter.getTimeline(for: userTag, excludeReplies: true, includeRetweets: false, success: { json in
            if let data = self.parseArrayJsonToData(json) {
                completion(self.decodeTweets(from: data))
            }
        }, failure: self.failureHandler)
    }
    
    public func getUser(screenName: String, completion: @escaping (User?) -> Void) {
        let userTag = UserTag.screenName(screenName)
        self.swifter.showUser(userTag, success: { json in
            let data = self.parseJsonToData(json)
            completion(self.decodeUser(from: data))
        }, failure: self.failureHandler)
    }
    
    public func getTweetWithId(_ idStr: String, completion: @escaping (ExtendedTweet?) -> Void) {
        swifter.getTweet(for: idStr, tweetMode: .extended, success: { json in
            let data = self.parseJsonToData(json)
            completion(self.decodeTweet(from: data))
        }, failure: self.failureHandler)
    }
    
    private func parseArrayJsonToData(_ json: JSON) -> Data? {
        if let jsonString = json.array?.description {
            let jsonData = Data(jsonString.utf8)
            return jsonData
        }
        return nil
    }
    
    private func parseJsonToData(_ json: JSON) -> Data {
        let jsonString = json.description
        let jsonData = Data(jsonString.utf8)
        return jsonData
    }
    
    private func decodeTweets(from data: Data) -> [Tweet]? {
        guard let tweets = try? JSONDecoder().decode([Tweet].self, from: data) else {
            return nil
        }
        return tweets
    }
    
    private func decodeTweet(from data: Data) -> ExtendedTweet? {
        guard let tweet = try? JSONDecoder().decode(ExtendedTweet.self, from: data) else {
            return nil
        }
        return tweet
    }
    
    private func decodeUser(from data: Data) -> User? {
        guard let user = try? JSONDecoder().decode(User.self, from: data) else {
            return nil
        }
        return user
    }
}
