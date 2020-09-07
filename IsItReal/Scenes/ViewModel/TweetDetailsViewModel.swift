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
    
    var shortText: String {
        if let index = self.tweet.text.index(of: "https://") {
            let shortText = String(self.tweet.text[..<index])
            return shortText
        }
        
        return self.tweet.text
    }
    
    var link: String {
        return "https://twitter.com/\(tweet.user.screenName)/status/\(tweet.idStr)"
    }
    var isValid: Bool? {
        return true
    }
    
    var userImagePhoto: URL {
        guard let url = URL(string: tweet.user.profileImage) else {
            return URL(fileURLWithPath: "")
        }
        return url
    }
    
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
        if let createdDate = dateFormatter.date(from: tweet.createdDate) {
            let dateFormatterR = DateFormatter()
            dateFormatterR.dateFormat = "h:mm a • E d, yyyy"
            let createdDateString = dateFormatterR.string(from: createdDate)
            return createdDateString
        }
        return tweet.createdDate
    }
}

extension TweetDetailsViewModel: Equatable {
    static func == (lhs: TweetDetailsViewModel, rhs: TweetDetailsViewModel) -> Bool {
        return lhs.tweet.idStr == rhs.tweet.idStr
    }
}
