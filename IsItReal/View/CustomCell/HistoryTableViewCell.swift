//
//  HistoryTableViewCell.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 13/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    fileprivate var tweetUserName: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    fileprivate var tweetScreenName: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    fileprivate var tweetText: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    func configure(viewModel: TweetDetailsViewModel) {
        // TODO: update all views
        self.textLabel?.text = viewModel.tweet.user.name
        self.detailTextLabel?.text = viewModel.tweet.text
    }
}
