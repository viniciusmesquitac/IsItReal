//
//  TweetRepositoryTests.swift
//  IsItRealTests
//
//  Created by Vinicius Mesquita on 21/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import XCTest
@testable import IsItReal

class HistoryList: XCTestCase {
    
    let viewModel = ListTweetViewModel(repository: MockRepository())
    
    override func setUp() {
        viewModel.tweetsDetailsViewModel = viewModel.getTweets()
    }
    
    func test_HistoryList_numberOfRows() {
        let n = viewModel.numberOfRows
        XCTAssertEqual(n, 5)
    }
    
    func test_HistoryList_getTweet() {
        let tweet = viewModel.getTweet(for: 3)
        let text = tweet?.tweet.text
        XCTAssertEqual("Hello World", text)
    }
}
