//
//  ImageAnalyser.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 28/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

protocol ImageAnalyserDelegate: class {
    func setLoading(_ state: Bool)
    func handleError(_ error: Error)
    func handleLatestTweets(_ tweets: [Tweet]?)
}

class ImageAnalyser {
    
    let imageReader = ImageReader()
    let service = APITwitter.shared
    weak var delagate: ImageAnalyserDelegate?
    
    public func start(image: UIImage, completion: @escaping (Tweet?) -> Void) throws {
        service.failureHandler = { error in
            self.delagate?.handleError(error)
        }
        let textResultsExtractedFromImage = try imageReader.perform(on: image, recognitionLevel: .fast)
        
        try imageReader.createQuery(text: textResultsExtractedFromImage, completion: { result in
            self.searchTweetWithImageQuery(result, completion: { tweet in
                completion(tweet)
            })
        })
    }
    
    private func searchTweetWithImageQuery(_ query: TweetQuery, completion: @escaping (Tweet?) -> Void) {
        guard let textFromQuery = query.query else {
            delagate?.handleError(ImageReaderError.impossibleToFindTheText)
            return
        }
        
        service.searchCompactTweet(query: textFromQuery) { tweets in
            guard let tweets = tweets else {
                self.delagate?.handleError(ImageAnalyserError.notFound)
                return
            }
            if let tweet = self.getTweet(from: tweets, with: query.user) {
                completion(tweet)
            } else {
                self.service.getLatest(screenName: query.user!, completion: { tweets in
                    self.delagate?.handleLatestTweets(tweets)
                })
            }
        }
    }
    
    private func getTweet(from tweets: [Tweet], with screenName: String?) -> Tweet? {
        for tweet in tweets where tweet.user.screenName == screenName {
            return tweet
        }
        return nil
    }
}
