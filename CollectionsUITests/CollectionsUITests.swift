//
//  CollectionsUITests.swift
//  CollectionsUITests
//
//  Created by Vitaly Khryapin on 10.12.2021.
//

import XCTest

class CollectionsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testTextFieldIsNotNumber() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Set"]/*[[".cells.staticTexts[\"Set\"]",".staticTexts[\"Set\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["inputTF"].tap()
        app.textFields["inputTF"].typeText("qw12er")
        let resultFirstTF = "qwer"
        app.textFields["exceptionTF"].tap()
        app.textFields["exceptionTF"].typeText("qw12")
        let resultSecondTF = "qw"
        XCTAssertEqual(resultFirstTF, app.textFields["inputTF"].value as! String)
        XCTAssertEqual(resultSecondTF, app.textFields["exceptionTF"].value as! String)
    }
    
    func testButtons() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Set"]/*[[".cells.staticTexts[\"Set\"]",".staticTexts[\"Set\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["inputTF"].tap()
        app.textFields["inputTF"].typeText("qw")
        app.textFields["exceptionTF"].tap()
        app.textFields["exceptionTF"].typeText("q")
        app/*@START_MENU_TOKEN@*/.staticTexts["All matching letters"]/*[[".buttons[\"All matching letters\"].staticTexts[\"All matching letters\"]",".staticTexts[\"All matching letters\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let resultFirstResult = app.staticTexts["firstResult"]
        XCTAssertEqual(resultFirstResult.label, "q")
        app/*@START_MENU_TOKEN@*/.staticTexts["All characters that do not match"]/*[[".buttons[\"All characters that do not match\"].staticTexts[\"All characters that do not match\"]",".staticTexts[\"All characters that do not match\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let resultSecondResult = app.staticTexts["secondResult"]
        XCTAssertEqual(resultSecondResult.label, "w")
        app/*@START_MENU_TOKEN@*/.staticTexts["All unique characters from the first text field that do not match in text fields"]/*[[".buttons[\"All unique characters from the first text field that do not match in text fields\"].staticTexts[\"All unique characters from the first text field that do not match in text fields\"]",".staticTexts[\"All unique characters from the first text field that do not match in text fields\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let resultThirdResult = app.staticTexts["thirdResult"]
        XCTAssertEqual(resultThirdResult.label, "w")
    }
    
    
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
