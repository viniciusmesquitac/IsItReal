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
    var handleUpdate: () -> Void { get set }
}

struct ListTweetViewModel: ConfigurableViewModel {
    
    typealias Repository = TweetRepository
    
    public var handleUpdate: () -> Void = {}
    
    fileprivate var repository = Repository()
    
    fileprivate var tweetsDetailsViewModel: [TweetDetailsViewModel]
    
    public var numberOfRows: Int {
        if tweetsDetailsViewModel.count == 0 {
            return getTweets().count
        }
        return tweetsDetailsViewModel.count
    }
    
    private func getTweets() -> [TweetDetailsViewModel] {
        // TODO: Recieve all tweets from repository and add to `tweetsDetailsViewModel`
        
        return []
    }
    
    public func getTweet(for index: Int) -> TweetDetailsViewModel? {
        if index < tweetsDetailsViewModel.count {
            return tweetsDetailsViewModel[index]
        }
        return nil
    }
    
}
