//
//  Discount_LocatorUITests.swift
//  Discount LocatorUITests
//
//  Created by Faculty of Organisation and Informatics on 23/01/16.
//  Copyright © 2016 air. All rights reserved.
//

import XCTest

class Discount_LocatorUITests: XCTestCase {
        
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
    
    func testExample() {
        
        let app = XCUIApplication()
        NSThread.sleepForTimeInterval(4)
        app.tables.staticTexts["Super Nova"].tap()
        app.tables.staticTexts["For two paid products, the third product (with the lowest price) is given for free in all stores of Super Nova shopping center."].tap()
        app.alerts["📈 Three for two : 30%"].collectionViews.buttons["Close"].tap()
        app.navigationBars["Discounts"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        
        app.navigationBars["Discount_Locator.VcNav"].buttons["Image"].tap()
        app.tables.staticTexts["Map"].tap()
        app.otherElements["Varteks, Popust na sve kolekcije ljetne odjeu0107e u Varteks Outlet duu0107anu."].tap()
        
    }
    
}
