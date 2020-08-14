//
//  TweetListViewModel.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import Foundation

struct TweetDetailsViewModel {
    var tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
}

extension TweetDetailsViewModel {
    var tweetScreenName: String {
        return "@\(tweet.user.screenName)"
    }
    
    var link: String {
        return "https://twitter.com/\(tweet.user.screenName)/status/\(tweet.idStr)"
    }
    var isValid: Bool? {
        return false
    }
}


extension TweetDetailsViewModel: Equatable {
    
    static func == (lhs: TweetDetailsViewModel, rhs: TweetDetailsViewModel) -> Bool {
        return lhs.tweet.idStr == rhs.tweet.idStr
    }
    
    
}
