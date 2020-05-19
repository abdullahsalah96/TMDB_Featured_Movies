//
//  MoviesListViewTests.swift
//  InstabugTaskUITests
//
//  Created by Abdalla Elshikh on 5/19/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import XCTest

class MoviesListViewTests: XCTestCase {
    let app = XCUIApplication()
    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    // MARK: - Testing when app is launched no errors are displayed
    func testNoErrorsAtLaunch(){
        let alert = app.alerts["Error"]
        XCTAssertFalse(alert.exists)
    }
    // MARK: - Testing when app is launched my movies section exists
    func testMyMoviesSectionExists(){
        XCTAssertTrue(app.tables.staticTexts["My Movies"].exists)
    }
    // MARK: - Testing when app is launched all movies section exists
    func testAllMoviesSectionExists(){
        XCTAssertTrue(app.tables.staticTexts["All Movies"].exists)
    }
    // MARK: - Test when app is launched table is not empty
    // this is done by checking count of all static texts in table as it should be greater than 2 (2 sections with 2 texts)
    func testTableContainsMovies(){
        let numberOfStaticTexts = app.tables.staticTexts.count
        XCTAssertTrue(numberOfStaticTexts > 2)
    }
    // MARK: - Test when app is launched add movie button exists
    func testAddMovieButtonExists(){
        let button = app.navigationBars["Movies"].buttons["Add"]
        XCTAssertTrue(button.exists)
    }
    // MARK: - Testing when app is launched, first view is Movies View Controller
    func testMovieVCExists(){
        let element = app.navigationBars["Movies"]
        XCTAssertTrue(element.exists)
    }
    // MARK: - Testing when app is launched, Add movies view doesn't exist
    func testNoAddMovieVC(){
        let element = app.navigationBars["Add New Movie"]
        XCTAssertFalse(element.exists)
    }
    // MARK: - Testing when Add button is pressed, Add moive VC is presented
    func testAddButtonPressed(){
        let button = app.navigationBars["Movies"].buttons["Add"]
        button.tap()
        let element = app.navigationBars["Add New Movie"]
        XCTAssertTrue(element.exists)
    }
}
