//
//  CoreUnitTests.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 21/01/16.
//  Copyright © 2016 air. All rights reserved.
//

import XCTest
import core
import db
import SwiftyJSON

class CoreUnitTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testParsing(){

        let jsonStores: [String: AnyObject] = [
            "items": "[{\"id\": \"1\",\"name\": \"1\",\"description\": \"1\",\"imgUrl\": \"1\",\"longitude\": \"1\",\"latitude\": \"1\"},{\"id\": \"1\",\"name\": \"1\",\"description\": \"1\",\"imgUrl\": \"1\",\"longitude\": \"1\",\"latitude\": \"1\"}]",
        ]
        let stores = JsonAdapter.getStores(jsonStores)
        XCTAssertTrue(stores.count==2, "nije vratio 2 dućana")
    }
    
    func testJsonAdapterStores(){
        let resultEmptyString = JsonAdapter.getStores("")
        let wrongObject: [String: AnyObject] = [
            "test": "1",
        ]
        let resultWrongObject = JsonAdapter.getStores(wrongObject)
        let normalObject: [String: AnyObject] = [
            "items": "[{\"id\": \"1\",\"name\": \"Super nova\",\"description\": \"Veliko blagdansko snizenje\",\"imgUrl\": \"cortex.foi.hr/slika2.png\",\"longitude\": \"16\",\"latitude\": \"46\"}]",
        ]
        let resultNormal = JsonAdapter.getStores(normalObject)
        
        XCTAssertEqual(resultEmptyString.count, 0, "treba biti nula")
        XCTAssertEqual(resultWrongObject.count, 0, "treba biti nula")
        
        XCTAssertEqual(resultNormal[0].name, "Super nova", "naziv ducana nije tocan")
        
    }
}
