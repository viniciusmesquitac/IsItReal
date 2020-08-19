//
//  ListTweetViewModel.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

protocol ConfigurableViewModel {
    associatedtype Repository
    var handleUpdate: (() -> Void)? { get set }
}

class ListTweetViewModel: ConfigurableViewModel {
    
    typealias Repository = TweetRepository
    
    public var handleUpdate: (() -> Void)?
    
    var repository = Repository.instance
    
    var tweetsDetailsViewModel: [TweetDetailsViewModel] = [] {
        didSet {
            DispatchQueue.main.async { self.handleUpdate?() }
        }
    }
    
    public var numberOfRows: Int {
        return tweetsDetailsViewModel.count
    }
    
    public func cellViewModel(at index: Int) -> TweetDetailsViewModel? {
        let tweet = getTweet(for: index)
        return tweet
    }
    
    public func getTweets() -> [TweetDetailsViewModel] {
        // TODO: Recieve all tweets from repository and add to `tweetsDetailsViewModel`
        let tweets = repository.getAll()
        
        self.tweetsDetailsViewModel = tweets.map({TweetDetailsViewModel(tweet: $0)})
        return tweetsDetailsViewModel
    }
    
    public func getTweet(for index: Int) -> TweetDetailsViewModel? {
        if index < tweetsDetailsViewModel.count {
            return tweetsDetailsViewModel[index]
        }
        return nil
    }
    
    public func handleSelectedTweets(at rows: [IndexPath]) {
        var tweets = [TweetDetailsViewModel]()
        
        for indexPath in rows {
            tweets.append(tweetsDetailsViewModel[indexPath.row])
        }
        
        for tweet in tweets {
            if let index = tweetsDetailsViewModel.firstIndex(of: tweet) {
                tweetsDetailsViewModel.remove(at: index)
                let result = repository.delete(object: tweet.tweet)
                print(result)
            }
        }
        
        self.handleUpdate?()
        
    }
}
