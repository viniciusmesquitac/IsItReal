//
//  TweetResultsViewModel.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 28/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class TweetResultsViewModel: ListTweetViewModel {
    
    var removeElementUpdate: ((TweetDetailsViewModel, IndexPath) -> Void)?
    
    func saveTweet(tweet: TweetDetailsViewModel) {
        var tweet = tweet.tweet
        let id = tweet.idStr
        
        APITwitter.shared.getTweetWithId(id) { extendedTweet in
            tweet.fullText = extendedTweet?.fullText
            tweet.dateAnalyses = self.createAnalyseDate()
            _ = self.repository.add(object: tweet)
        }
    }
    
    func removeTweet(_ tweet: TweetDetailsViewModel) {
        if let index = tweetsDetailsViewModel.firstIndex(of: tweet) {
            tweetsDetailsViewModel.remove(at: index)
        }
    }
    
    func alertSaveConfirm(_ presentFrom: UIViewController, tweet: TweetDetailsViewModel, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Save tweet?", message: "Save tweet in history tweets", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.saveTweet(tweet: tweet)
            self.removeElementUpdate?(tweet, indexPath)
        }))
        presentFrom.present(alert, animated: true, completion: nil)
    }
    
}
