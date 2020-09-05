//
//  AnalysesTweetViewModel.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 18/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class AnalysesTweetViewModel: ConfigurableViewModel {
    
    var handleUpdate: (() -> Void)?
    
    typealias Repository = TweetRepository
    public var handleSavedTweet: ((Tweet) -> Void)?
    var repository = Repository()
    
    func saveTweet(_ tweet: Tweet?, image: URL?) {
        guard var tweet = tweet else { return }
        tweet.dateAnalyses = createAnalyseDate()
        _ = self.repository.add(object: tweet)
        handleSavedTweet?(tweet)
    }
    
    func createAnalyseDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        return formatter.string(from: currentDate)
    }

    func failureHandler(_ presentFrom: UIViewController, error: Error) {
        self.alert(presentFrom, title: "ERROR", message: "\(error.localizedDescription)")
        if let controller = presentFrom as? AnalyseTweetViewController {
            controller.rootView.setLoadingAnalyseButton(false)
        }
    }

    func alert(_ presentFrom: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        presentFrom.present(alert, animated: true, completion: nil)
    }
}
