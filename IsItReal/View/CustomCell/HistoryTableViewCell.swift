//
//  HistoryTableViewCell.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let nibName = "HistoryTableViewCell"
    static let cellId = "tweetHistoryCell"
    
    @IBOutlet weak var tweetUserName: UILabel!
    @IBOutlet weak var tweetScreenName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetValidation: UILabel!
    @IBOutlet weak var leadingFromCell: NSLayoutConstraint!
    
    func configure(viewModel: TweetDetailsViewModel) {
        // Update all views
        tweetUserName.text = viewModel.tweet.user.name
        tweetScreenName.text = viewModel.tweetScreenName
        tweetText.text = viewModel.tweet.text
//        tweetValidation.text = viewModel.isValid
    }
    
    override func setNeedsUpdateConstraints() {
        if isEditing {
            self.leadingFromCell.constant = leadingFromCell.constant + 32.0
        } else {
            self.leadingFromCell.constant = 16
        }
        
    }
}
