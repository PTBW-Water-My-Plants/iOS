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
    
    func  test_registration_Tapped() {
        
        // I am not gonna lie this thing kept on failing the test until I stoped the build. Ran the code. Sign out of the app. An than ran the test and it worked. So simple but omg it took me like no Joke 30 mins to figure this test out.
            
        let validPassword = ""
        let validEmail = ""
        let valedPhoneNumber = ""
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["SIGN UP"]/*[[".buttons[\"SIGN UP\"].staticTexts[\"SIGN UP\"]",".buttons[\"SignUPButton\"].staticTexts[\"SIGN UP\"]",".staticTexts[\"SIGN UP\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let emailTextField = app/*@START_MENU_TOKEN@*/.textFields["EmailTextField"]/*[[".textFields[\"Email\"]",".textFields[\"EmailTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText(validEmail)
        
        let secureTextFields = app/*@START_MENU_TOKEN@*/.secureTextFields["PasswordTextFied"]/*[[".secureTextFields[\"Password\"]",".secureTextFields[\"PasswordTextFied\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(secureTextFields.exists)
        secureTextFields.tap()
        secureTextFields.typeText(validPassword)
        
        let phonenumbertextfieldTextField = app/*@START_MENU_TOKEN@*/.textFields["PhonenumberTextField"]/*[[".textFields[\"Phone Number\"]",".textFields[\"PhonenumberTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(phonenumbertextfieldTextField.exists)
        phonenumbertextfieldTextField.tap()
        phonenumbertextfieldTextField.typeText(valedPhoneNumber)
        
        let signUPButton = app/*@START_MENU_TOKEN@*/.staticTexts["Sign Up"]/*[[".buttons[\"Sign UP\"].staticTexts[\"Sign Up\"]",".buttons[\"SignUpNewAccount\"].staticTexts[\"Sign Up\"]",".staticTexts[\"Sign Up\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(signUPButton.exists)
       
    
    }
    
    func testLoginPassword() {
        
        // I wanted to test to pop the aleart for when one got the wrong pass word but was albe to successfully bring it up 
        
        let validPassword = ""
        let validEmail = ""
        let valedPhoneNumber = ""
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["LOG IN"]/*[[".buttons[\"LOG IN\"].staticTexts[\"LOG IN\"]",".staticTexts[\"LOG IN\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let emailTextField = app.textFields["Email"]
        
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText(validEmail)
        
        let secureTextFields = app.secureTextFields["Password"]
        
        XCTAssertTrue(secureTextFields.exists)
        secureTextFields.tap()
        secureTextFields.typeText(validPassword)
        
        
        let phonenumbertextfieldTextField = app.textFields["Phone Number"]
        
        XCTAssertTrue(phonenumbertextfieldTextField.exists)
        phonenumbertextfieldTextField.tap()
        phonenumbertextfieldTextField.typeText(valedPhoneNumber)
        
        let loginButton = app.buttons["LOG IN"]
        
        XCTAssertTrue(loginButton.exists)
        
        let alertWrongPassword = app.alerts["Error"]
        
        XCTAssertFalse(alertWrongPassword.exists)
        
//        alertWrongPassword.scrollViews.otherElements.buttons["Dismiss"].tap()
        
    }

        func testLaunchPerformance() {
            if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
                // This measures how long it takes to launch your application.
                measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                    XCUIApplication().launch()
                }
            }
        }
    
}
