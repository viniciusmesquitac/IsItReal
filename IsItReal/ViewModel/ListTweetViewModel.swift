//
//  ListTweetViewModel.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

protocol ConfigurableViewModel {
    associatedtype Repository
    var handleUpdate: (() -> Void)? { get set }
}

class ListTweetViewModel: ConfigurableViewModel {
    
    typealias Repository = MockRepository
    
    public var handleUpdate: (() -> Void)?
    
    var repository = Repository()
    
    var tweetsDetailsViewModel: [TweetDetailsViewModel] = []
    
    public var numberOfRows: Int {
        if tweetsDetailsViewModel.count == 0 {
            return getTweets().count
        }
        return tweetsDetailsViewModel.count
    }
    
    public func cellViewModel(at index: Int) -> TweetDetailsViewModel? {
        let tweet = getTweet(for: index)
        return tweet
    }
    
    private func getTweets() -> [TweetDetailsViewModel] {
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
}
