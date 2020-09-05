//
//  TweetResultsViewModel.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 28/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class TweetResultsViewModel: ListTweetViewModel {
    
    func saveTweet(tweet: TweetDetailsViewModel) {
        var tweet = tweet.tweet
        tweet.dateAnalyses = createAnalyseDate()
        _ = self.repository.add(object: tweet)
    }
    
    func alertSaveConfirm(_ presentFrom: UIViewController, tweet: TweetDetailsViewModel) {
        let alert = UIAlertController(title: "Save tweet?", message: "Save tweet in history tweets", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.saveTweet(tweet: tweet)
        }))
        presentFrom.present(alert, animated: true, completion: nil)
    }
    
}
