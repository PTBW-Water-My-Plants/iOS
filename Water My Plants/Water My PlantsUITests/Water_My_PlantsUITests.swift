//
//  Water_My_PlantsUITests.swift
//  Water My PlantsUITests
//
//  Created by Gladymir Philippe on 10/21/20.
//

import XCTest
@testable import Water_My_Plants

class Water_My_PlantsUITests: XCTestCase {
    
    private var newMessageTextFieldTextView: XCUIElement {
       return app.textViews["MessageDetailViewController.messageTextView"]
    }
    
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
            // Put setup code here. This method is called before the invocation of each test method in the class.
            // In UI tests it is usually best to stop immediately when a failure occurs.
            continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()

            // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        }

        override func tearDown() {
            super.tearDown()
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }

    func testLoging() {
            // UI tests must launch the application that they test.

        

        
        
        let app = XCUIApplication()
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["LOG IN"]/*[[".buttons[\"LOG IN\"].staticTexts[\"LOG IN\"]",".staticTexts[\"LOG IN\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertEqual(app.buttons.element.title, "Login")


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
