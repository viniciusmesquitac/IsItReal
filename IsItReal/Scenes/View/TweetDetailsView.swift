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
    @IBOutlet weak var linkTweetContainerView: LinkTweetContainerView!
    @IBOutlet weak var ValidTweetContainerView: ValidTweetContainer!
    
    func configure(viewModel: TweetDetailsViewModel) {
        self.tweetContainerView.userLabel.text = viewModel.tweet.user.name
        self.tweetContainerView.userScreenName.text = "@"+viewModel.tweet.user.screenName
        self.tweetContainerView.tweetText.text = viewModel.tweet.text
        self.tweetContainerView.createDate.text = viewModel.createdDate
        self.linkTweetContainerView.link.text = viewModel.link
        Nuke.loadImage(with: viewModel.userImagePhoto, into: self.tweetContainerView.userPhoto)
        
    }
    
    func teste() {
        print("ola!")
    }
}

class TweetContainerView: UIView {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var createDate: UILabel!
}

class LinkTweetContainerView: UIView {
    @IBOutlet weak var link: UILabel!
    @IBOutlet weak var buttonLink: UIButton!
}

class ValidTweetContainer: UIView {
    @IBOutlet weak var isValidLabel: UILabel!
}
