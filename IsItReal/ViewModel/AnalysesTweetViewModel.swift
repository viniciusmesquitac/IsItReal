//
//  AnalysesTweetViewModel.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 18/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class AnalysesTweetViewModel: ConfigurableViewModel {
    
    typealias Repository = TweetRepository
    public var handleUpdate: (() -> Void)?
    
    var repository = Repository.instance
    
    func handleQueryResults(_ query: QueryResult) -> String {
        guard let text = query.query else { return "" }
        return text
    }
    
    func saveTweets(tweets: [Tweet]?) {
        if let tweet = tweets?.first {
            _ = self.repository.add(object: tweet)
            handleUpdate?()
        }
    }

    func failureHandler(_ presentFrom: UIViewController, error: AnalyseError) {
        switch error {
        case .notImage:
            self.alert(presentFrom, title: "ERROR", message: "Select an image to analyse")
        }
    }

    func alert(_ presentFrom: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        presentFrom.present(alert, animated: true, completion: nil)
    }
}
enum AnalyseError: Error {
    case notImage
}
