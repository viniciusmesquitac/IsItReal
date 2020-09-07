//
//  TweetDetailsView.swift
//  IsItReal
//
//  Created by Vinicius Mesquita on 20/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import UIKit
import Nuke

class TweetDetailsView: UIView {
    
    @IBOutlet weak var tweetContainerView: TweetContainerView!
    @IBOutlet weak var ValidTweetContainerView: ValidTweetContainer!
    @IBOutlet weak var safariButton: UIButton!
    
    let options = ImageLoadingOptions(
        placeholder: UIImage(named: "placeholder"),
        transition: .fadeIn(duration: 0.33)
    )
    
    func configure(viewModel: TweetDetailsViewModel) {
        self.tweetContainerView.userLabel.text = viewModel.tweet.user.name
        self.tweetContainerView.userScreenName.text = "@"+viewModel.tweet.user.screenName
        self.tweetContainerView.tweetText.text = viewModel.tweet.fullText
        self.tweetContainerView.createDate.text = viewModel.createdDate
        self.safariButton.setTitle(viewModel.link, for: .normal)
        Nuke.loadImage(with: viewModel.userImagePhoto, options: options, into: self.tweetContainerView.userPhoto)
    }
}

class TweetContainerView: UIView {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var createDate: UILabel!
}

class ValidTweetContainer: UIView {
    @IBOutlet weak var isValidLabel: UILabel!
}
