//
//  WebServiceUnitTest.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 21/01/16.
//  Copyright © 2016 air. All rights reserved.
//

import XCTest
import ws
class WebServiceUnitTests: XCTestCase {

    var expectation:XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHTTPReqObject() {
        XCTAssertNotNil(HTTPRequest(), "http request objekt je nil")
        XCTAssertNil(HTTPRequest().delegate, "delegat nije nil") //delegat bi trebao prilikom kreacije biti nil
        self.expectation = expectationWithDescription("nije se vratio rezultat")
        
        let httpRequest = HTTPRequest()
        httpRequest.delegate = self
        httpRequest.httprequest("http://cortex.foi.hr/mtl/courses/air/stores.php", params: ["method":"getAll"])

        waitForExpectationsWithTimeout(4, handler: nil)
    }
    
    func testInternetConnection(){
        XCTAssertTrue(NetConnection.Connection.isConnectedToNetwork(),"Uređaj nije spojen na internet")
    }
}

extension WebServiceUnitTests:WebServiceResultDelegate{

    func getResult(json: AnyObject) {
        self.expectation.fulfill()
    }
}
