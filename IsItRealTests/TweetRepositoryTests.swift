//
//  TweetRepositoryTest.swift
//  IsItRealTests
//
//  Created by Vinicius Mesquita on 23/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//


import XCTest
@testable import IsItReal

class TweetRepositoryTests: XCTestCase {
    
    var repository: TweetRepository!
    var tweet: Tweet!
    
    override func setUp() {
        repository = TweetRepository()
        tweet = MockRepository().getAll()[0]
    }
    
    func testA_addTweet_true() {
        let result = repository.add(object: tweet)
        XCTAssert(result)
    }
    
    func testB_removeTweet_true() {
        let result = repository.delete(object: tweet)
        XCTAssert(result)
    }
    
    func testC_getAll_count2() {
        let tweets = repository.getAll()
        let count = tweets.count
        XCTAssertEqual(count, 0)
    }
    
}
