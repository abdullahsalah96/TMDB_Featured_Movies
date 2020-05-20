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
        navigateToAddMovies()
        let moviesButton = app.buttons["Movies"].firstMatch
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: moviesButton, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    // MARK: - Testing when back button pressed movies controller is presented
    func testBackButtonPressed(){
        navigateToAddMovies()
        app.buttons["Movies"].firstMatch.tap()
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: app.navigationBars["Movies"].firstMatch, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing title label exists
    func testTitleLabelExists(){
        navigateToAddMovies()
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: app.staticTexts["Title"].firstMatch, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing title text field exists
    func testTitleTextFieldExists(){
        navigateToAddMovies()
        let element = getElement()
        let textField = element.children(matching: .textField).element
        textField.tap()
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: textField, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing overview label exists
    func testOverviewLabelExists(){
        navigateToAddMovies()
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: app.staticTexts["Overview"], handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing overview text view exists
    func testOverviewTextViewExists(){
        navigateToAddMovies()
        let element = getElement()
        let textView = element.children(matching: .textView).element
        textView.tap()
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: textView, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing Date label exists
    func testDateLabelExists(){
        navigateToAddMovies()
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: app.staticTexts["Date"].firstMatch, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing Date picker exists
    func testDatePickerExists(){
        navigateToAddMovies()
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: app.datePickers.element.firstMatch, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing Image view exists
    func testImageViewExists(){
        navigateToAddMovies()
        let imageView = app.images["pressImage"].firstMatch
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: imageView, handler: nil)
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    // MARK: - Testing invalid title error
    func testInvalidTitleError(){
        navigateToAddMovies()
        app.buttons["Add Movie"].firstMatch.tap()
        let alert = app.alerts["Error"].firstMatch
        XCTAssertTrue(alert.firstMatch.exists)
    }
    
    // MARK: - Testing invalid overview error
    func testInvalidOverviewError(){
        navigateToAddMovies()
        // set valid title
        let element = getElement()
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
        navigateToAddMovies()
        // set valid title
        let element = getElement()
        let textField = element.children(matching: .textField).element
        textField.tap()
        // set text of text field
        let title = "Valid movie title"
        textField.typeText(title)
        // press return
        let returnButton = app.buttons["Return"].firstMatch
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
