//
//  GitKubUITests.swift
//  GitKubUITests
//
//  Created by golfiti on 6/5/2559 BE.
//  Copyright © 2559 golfiti. All rights reserved.
//

import XCTest

class GitKubUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUserRepoSuccess() {
        
        let app = XCUIApplication()
        XCUIDevice.sharedDevice().orientation = .Portrait
        app.textFields["GitHub Username"].tap()
        app.typeText("golfiti")
        app.buttons["Profile"].tap()
    }
    
    func testGetUserZeroRepo() {
        let app = XCUIApplication()
        XCUIDevice.sharedDevice().orientation = .Portrait
        app.textFields["GitHub Username"].tap()
        app.typeText("dave")
        app.buttons["Profile"].tap()
        
        let appAlert = app.alerts["GitKub"]
        let exists = NSPredicate(format: "exists == 1")
        expectationForPredicate(exists, evaluatedWithObject: appAlert, handler: nil)
        app.alerts["GitKub"].collectionViews.buttons["Done"].tap()
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func testGetNotFoundUser() {
        let app = XCUIApplication()
        XCUIDevice.sharedDevice().orientation = .Portrait
        app.textFields["GitHub Username"].tap()
        app.typeText("asdasjfafsa")
        app.buttons["Profile"].tap()
        
        let appAlert = app.alerts["GitKub"]
        let exists = NSPredicate(format: "exists == 1")
        expectationForPredicate(exists, evaluatedWithObject: appAlert, handler: nil)
        app.alerts["GitKub"].collectionViews.buttons["Done"].tap()
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
}
