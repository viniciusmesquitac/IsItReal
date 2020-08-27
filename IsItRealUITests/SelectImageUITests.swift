//
//  SelectImageUITests.swift
//  IsItRealUITests
//
//  Created by Vinicius Mesquita on 26/08/20.
//  Copyright © 2020 Vinicius Mesquita. All rights reserved.
//

import XCTest

class SelectImageUITests: XCTestCase {

    let app = XCUIApplication()
    override func setUp() {
        app.launch()
    }

    func test_addImage_imageResult() {
        XCUIApplication().buttons["Select Photo"].tap()
    }
}
