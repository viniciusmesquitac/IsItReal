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
    
    var repository = Repository()
    
    func handleQueryResults(_ query: QueryResult) -> String {
        // Handle results and show errors
        guard let text = query.query else { return "" }
        return text
    }
    
    func saveTweets(tweets: [Tweet]?) {
        // Sanving
        if let tweet = tweets?.first {
            _ = self.repository.add(object: tweet)
            handleUpdate?()
        }
    }
    
    func failureHandler(_ presentFrom: UIViewController, error: AnalyseError) {
        
        switch error {
        case .notImage:
            self.alert(title: "ERROR", message: "Select an image to analyse", presentFrom: presentFrom)
        default:
            print("NotFound")
        }
        
    }
    
    func alert(title: String, message: String, presentFrom: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        presentFrom.present(alert, animated: true, completion: nil)
    }
    
}
enum AnalyseError: Error {
    case notImage
}
