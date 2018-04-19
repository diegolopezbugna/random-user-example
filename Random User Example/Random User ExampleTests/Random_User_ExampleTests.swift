//
//  Random_User_ExampleTests.swift
//  Random User ExampleTests
//
//  Created by Diego López Bugna on 17/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import XCTest
@testable import Random_User_Example

class Random_User_ExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUsers() {
        let usersConnector = DummyUserConnector()
        usersConnector.getUsers { (users) in
            XCTAssert(users.count > 0)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
