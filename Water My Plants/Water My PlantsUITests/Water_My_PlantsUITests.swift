//
//  Water_My_PlantsUITests.swift
//  Water My PlantsUITests
//
//  Created by Gladymir Philippe on 10/21/20.
//

import XCTest

class Water_My_PlantsUITests: XCTestCase {
    
    private var app: XCUIApplication {
        return XCUIApplication()
    }
    
//    private var signOutButton: XCUIElement {
//        return app.buttons["ProfileViewController.Sign Out", "", ""]
//    }
    
    override func setUp() {
        super.setUp()
            // Put setup code here. This method is called before the invocation of each test method in the class.
            // In UI tests it is usually best to stop immediately when a failure occurs.
            continueAfterFailure = false

            // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        }

        override func tearDown() {
            super.tearDown()
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }

        func testExample() {
            // UI tests must launch the application that they test.
            let app = XCUIApplication()
            app.launch()
            
            XCUIApplication().navigationBars["Water_My_Plants.BaseTableView"].buttons["Sign Out"].tap()
            

            // Use recording to get started writing UI tests.
            // Use XCTAssert and related functions to verify your tests produce the correct results.
        }

        func testLaunchPerformance() {
            if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
                // This measures how long it takes to launch your application.
                measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                    XCUIApplication().launch()
                }
            }
        }
    
    func loginTest() {
        
    }
}
