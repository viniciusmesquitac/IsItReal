//
//  ImageAnalyser.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 28/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

class ImageAnalyser {
    
    let imageReader = ImageReader()
    let service = APITwitter.shared
    var handleFromLatestTweets: (([Tweet]?) -> Void)?
    var notFindImageError: (() -> Void)?
    var stopLoading: (() -> Void)?
    var startLoading: (() -> Void)?
    
    func start(imageUrl: URL, completion: @escaping (Tweet?) -> Void) throws {
        
        let textResultsExtractedFromImage = try imageReader.perform(on: imageUrl, recognitionLevel: .fast)
        
        try imageReader.createQuery(text: textResultsExtractedFromImage, completion: { result in
            self.searchTweetWithImageQuery(result, completion: { tweet in
                completion(tweet)
            })
        })
    }
    
    func searchTweetWithImageQuery(_ query: QueryResult, completion: @escaping (Tweet?) -> Void) {
        guard let textFromQuery = query.query else {  return print(ImageReaderError.impossibleToFindTheText.errorDescription ?? "") }
        
        if UserDefaultsManager.getAuthToken() != nil { // with auth
            service.searchCompactTweet(query: textFromQuery) { tweets in
                guard let tweets = tweets else { return }
                if let tweet = self.getTweet(from: tweets, with: query.user) {
                    completion(tweet)
                } else {
                    self.getLatestsTweets(with: query.user!, completion: { tweets in
                        self.handleFromLatestTweets?(tweets)
                    })
                }
            }
        } else {
            stopLoading?()
            service.searchTweet(query: textFromQuery) { tweets in // without auth
                self.startLoading?()
                guard let tweets = tweets else { return }
                if let tweet = self.getTweet(from: tweets, with: query.user) {
                    completion(tweet)
                } else {
                    self.getLatestsTweets(with: query.user!, completion: { tweets in
                        self.handleFromLatestTweets?(tweets)
                    })
                }
            }
        }
    }
    
    private func getLatestsTweets(with screenName: String, completion: @escaping ([Tweet]?) -> Void) {
        service.getLatest(screenName: screenName) { (tweets) in
            completion(tweets)
        }
    }
    
    private func getTweet(from tweets: [Tweet], with screenName: String?) -> Tweet? {
        for tweet in tweets where tweet.user.screenName == screenName {
            return tweet
        }
        return nil
    }
}
