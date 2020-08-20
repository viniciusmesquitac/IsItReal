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
    public var currentPresent: UIViewController?
    
    private init() {}
    
    private var swifter = Swifter(
        consumerKey: KEY,
        consumerSecret: SECRET)
    
    public var failureHandler: (Error) -> Void = { error in
        shared.alert(title: "ERROR", message: "\(error.localizedDescription)")
    }
    
    public func searchTweet(query: String, presentFrom: UIViewController?, completion: @escaping ([Tweet]?) -> Void) {
        
        currentPresent = presentFrom
        swifter.authorize(withCallback: AuthSwifter.url, presentingFrom: presentFrom, success: { (_, _) in
            
            self.swifter.searchTweet(using: query,  resultType: "popular", count: 100, success: { json, _ in
                if let jsonString = json.array?.description {
                    let jsonData = Data(jsonString.utf8)
                    let tweets = self.decodeTweets(from: jsonData)
                    completion(tweets)
                }
            }, failure: self.failureHandler)
            
        }, failure: self.failureHandler)
    }
    
    private func decodeTweets(from data: Data) -> [Tweet]? {
        let decoder = JSONDecoder()
        guard let tweets = try? decoder.decode([Tweet].self, from: data) else {
            return nil
        }
        return tweets
    }
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        currentPresent?.present(alert, animated: true, completion: nil)
    }
}

enum AuthSwifter {
    static let url: URL! = URL(string: "TwitterTestingAPI://success")
}
