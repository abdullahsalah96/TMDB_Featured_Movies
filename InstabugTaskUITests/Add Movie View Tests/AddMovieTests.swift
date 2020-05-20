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
        let button = app.buttons["Add"].firstMatch
        button.tap()
        let moviesButton = app.buttons["Movies"].firstMatch
        XCTAssertTrue(moviesButton.exists)
    }
    // MARK: - Testing when back button pressed movies controller is presented
    func testBackButtonPressed(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        app.buttons["Movies"].firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Movies"].firstMatch.exists)
    }
    
    // MARK: - Testing title label exists
    func testTitleLabelExists(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        XCTAssertTrue(app.staticTexts["Title"].firstMatch.exists)
    }
    
    // MARK: - Testing title text field exists
    func testTitleTextFieldExists(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        XCTAssertTrue(textField.exists)
    }
    
    // MARK: - Testing overview label exists
    func testOverviewLabelExists(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        XCTAssertTrue(app.staticTexts["Overview"].exists)
    }
    
    // MARK: - Testing overview text view exists
    func testOverviewTextViewExists(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textView = element.children(matching: .textView).element
        textView.tap()
        XCTAssertTrue(textView.exists)
    }
    
    // MARK: - Testing Date label exists
    func testDateLabelExists(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        XCTAssertTrue(app.staticTexts["Date"].firstMatch.exists)
    }
    
    // MARK: - Testing Date picker exists
    func testDatePickerExists(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        XCTAssertTrue(app.datePickers.element.firstMatch.exists)
    }
    
    // MARK: - Testing Image view exists
    func testImageViewExists(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        let imageView = app.images["pressImage"].firstMatch
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: imageView, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing invalid title error
    func testInvalidTitleError(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        app.buttons["Add Movie"].firstMatch.tap()
        let alert = app.alerts["Error"].firstMatch
        XCTAssertTrue(alert.firstMatch.exists)
    }
    
    // MARK: - Testing invalid overview error
    func testInvalidOverviewError(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
        // set valid title
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        // set text of text field
        textField.typeText("Valid movie title")
        // press return
        app.buttons["Return"].firstMatch.tap()
        // add movie
        app.buttons["Add Movie"].firstMatch.tap()
        let alert = app.alerts["Error"].firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    // MARK: - Testing valid movie data
    // Make sure keyboard is active
    func testValidMovieData(){
        _ = addValidMovie()
        let alert = app.alerts["Success"].firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    // MARK: - Testing correct movie title is added to table view
    // Make sure keyboard is active
    func testCorrectMovieTitleAddedToTableView(){
        let movieData = addValidMovie()
        let alert = app.alerts["Success"].firstMatch
        // press ok
        alert.scrollViews.otherElements.buttons["Ok"].firstMatch.tap()
        // press movies button to go back to movies list
        app.buttons["Movies"].firstMatch.tap()
        // make sure movie title exists
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: app.staticTexts[movieData[0]].firstMatch, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing correct movie overview is added to table view
    // Make sure keyboard is active
    /// When all tests are run at once and test movie overview is large, this test sometimes fails with "Failed to get matching snapshots: Timed out while evaluating UI query." error, I solved this with adding an expectaion and using a smaller movie overview, however, sometimes it still fails. Restarting the device then running this test also solves the problem
    func testCorrectMovieOverviewAddedToTableView(){
        let movieData = addValidMovie()
        let alert = app.alerts["Success"].firstMatch
        // press ok
        alert.scrollViews.otherElements.buttons["Ok"].firstMatch.tap()
        // press movies button to go back to movies list
        app.buttons["Movies"].firstMatch.tap()
        // make sure movie overview exists, wait for expectation
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: app.staticTexts[movieData[1]].firstMatch, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Helper function to add new movie
    // returns both movie title and overview
    func addValidMovie()->[String]{
        let button = app.buttons["Add"].firstMatch
        let returnButton = app.buttons["Return"].firstMatch
        button.tap()
        // set valid title
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .textField).element
        textField.tap()
        // set text of text field
        let title = "Valid movie title"
        textField.typeText(title)
        // press return
        returnButton.tap()
        // set movie overview
        let textView = element.children(matching: .textView).element
        textView.tap()
        let overview = "Movie overview > 30 characters"
        textView.typeText(overview)
        //press return
        returnButton.tap()
        // add movie
        app.buttons["Add Movie"].firstMatch.tap()
        return [title, overview]
    }
}
