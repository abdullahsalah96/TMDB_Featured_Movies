//
//  AddMovieTests.swift
//  InstabugTaskUITests
//
//  Created by Abdalla Elshikh on 5/19/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import XCTest

class AddMovieTests: XCTestCase {
    let app = XCUIApplication()
    // MARK: - Setup
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    // MARK: - Testing back to movies button exists
    func testBackButtonExists(){
        let button = app.buttons["Add"]
        button.tap()
        XCTAssertTrue(app.buttons["Movies"].exists)
    }
    // MARK: - Testing when back button pressed movies controller is presented
    func testBackButtonPressed(){
        let button = app.buttons["Add"]
        button.tap()
        app.buttons["Movies"].tap()
        XCTAssertTrue(app.navigationBars["Movies"].exists)
    }
    
    // MARK: - Testing title label exists
    func testTitleLabelExists(){
        let button = app.buttons["Add"]
        button.tap()
        XCTAssertTrue(app.staticTexts["Title"].exists)
    }
    
    // MARK: - Testing title text field exists
    func testTitleTextFieldExists(){
        let button = app.buttons["Add"]
        button.tap()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element.tap()
        let textField = element.children(matching: .textField).element
        XCTAssertTrue(textField.exists)
    }
    
    // MARK: - Testing overview label exists
    func testOverviewLabelExists(){
        let button = app.buttons["Add"]
        button.tap()
        XCTAssertTrue(app.staticTexts["Overview"].exists)
    }
    
    // MARK: - Testing overview text view exists
    func testOverviewTextViewExists(){
        let button = app.buttons["Add"]
        button.tap()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textView).element.tap()
        let textView = element.children(matching: .textView).element
        XCTAssertTrue(textView.exists)
    }
    
    // MARK: - Testing Date label exists
    func testDateLabelExists(){
        let button = app.buttons["Add"]
        button.tap()
        XCTAssertTrue(app.staticTexts["Date"].exists)
    }
    
    // MARK: - Testing Date picker exists
    func testDatePickerExists(){
        let button = app.buttons["Add"]
        button.tap()
        XCTAssertTrue(app.datePickers.element.exists)
    }
    
    // MARK: - Testing Image view exists
        func testImageViewExists(){
        let button = app.buttons["Add"]
        button.tap()
        let imageView = app.images["pressImage"]
        XCTAssertTrue(imageView.exists)
    }
    
    // MARK: - Testing invalid title error
    func testInvalidTitleError(){
        let button = app.buttons["Add"]
        button.tap()
        app.buttons["Add Movie"].tap()
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.exists)
    }
    
    // MARK: - Testing invalid overview error
    func testInvalidOverviewError(){
        let button = app.buttons["Add"]
        button.tap()
        // set valid title
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element.tap()
        let textField = element.children(matching: .textField).element
        // set text of text field
        textField.typeText("Valid movie title")
        // press return
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        // add movie
        app.buttons["Add Movie"].tap()
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.exists)
    }
    
    // MARK: - Testing valid movie data
    func testValidMovieData(){
        _ = addValidMovie()
        let alert = app.alerts["Success"]
        XCTAssertTrue(alert.exists)
    }
    
    // MARK: - Testing correct movie title is added to table view
    func testCorrectMovieTitleAddedToTableView(){
        let movieData = addValidMovie()
        let alert = app.alerts["Success"]
        // press ok
        alert.scrollViews.otherElements.buttons["Ok"].tap()
        // press movies button to go back to movies list
        app.buttons["Movies"].tap()
        // make sure movie title exists
        XCTAssertTrue(app.staticTexts[movieData[0]].exists)
    }
    
    // MARK: - Testing correct movie overview is added to table view
    func testCorrectMovieOverviewAddedToTableView(){
        let movieData = addValidMovie()
        let alert = app.alerts["Success"]
        // press ok
        alert.scrollViews.otherElements.buttons["Ok"].tap()
        // press movies button to go back to movies list
        app.buttons["Movies"].tap()
        // make sure movie overview exists
        XCTAssertTrue(app.staticTexts[movieData[1]].exists)
    }
    // MARK: - Helper function to add new movie
    // returns both movie title and overview
    func addValidMovie()->[String]{
        let button = app.buttons["Add"]
        button.tap()
        // set valid title
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .textField).element.tap()
        let textField = element.children(matching: .textField).element
        // set text of text field
        let title = "Valid movie title"
        textField.typeText(title)
        // press return
        app.buttons["Return"].tap()
        // set movie overview
        element.children(matching: .textView).element.tap()
        let textView = element.children(matching: .textView).element
        let overview = "This is a valid movie overview as it has more than 30 letters"
        textView.typeText(overview)
        //press return
        app.buttons["Return"].tap()
        // add movie
        app.buttons["Add Movie"].tap()
        return [title, overview]
    }
}
