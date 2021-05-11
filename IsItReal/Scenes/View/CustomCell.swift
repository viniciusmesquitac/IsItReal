//
//  CustomCell.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 19/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let nibName = "HistoryTableViewCell"
    static let cellId = "tweetHistoryCell"
    
    @IBOutlet weak var leadingFromCell: NSLayoutConstraint!
    @IBOutlet weak var tweetUserName: UILabel!
    @IBOutlet weak var tweetScreenName: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetValidation: UILabel!
    @IBOutlet weak var tweetValidationDate: UILabel!
    
    func configure(viewModel: TweetDetailsViewModel) {
        // Update all views
        tweetUserName.text = viewModel.tweet.user.name
        tweetScreenName.text = viewModel.tweetScreenName
        tweetText.text = viewModel.tweet.text
        tweetValidation.text = "Tweet Validated"
        tweetValidationDate.text = viewModel.tweet.dateAnalyses
    }
    
    override func setNeedsUpdateConstraints() {
        if isEditing {
            UIView.animate(withDuration: 0.3) {
                self.leadingFromCell.constant *= 3.5
                self.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.leadingFromCell.constant = 16
                self.layoutIfNeeded()
            }
        }
    }
}
