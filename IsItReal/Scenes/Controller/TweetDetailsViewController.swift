//
//  TweetDetailsViewController.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    var tweet: TweetDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            print(tweet.tweet.text)
        }
        // Do any additional setup after loading the view.
    }

}
