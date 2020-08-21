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
    @IBOutlet weak var rootView: TweetDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            rootView.configure(viewModel: tweet)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
