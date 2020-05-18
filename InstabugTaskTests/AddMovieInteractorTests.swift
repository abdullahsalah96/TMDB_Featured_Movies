//
//  AddMovieInteractorTests.swift
//  InstabugTaskTests
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.

import XCTest
@testable import InstabugTask

class AddMovieInteractorTests: XCTestCase {
    private let interactor = AddMovieInteractor()
    
    // MARK: - Testing setting an invalid title for a movie
    func testInvalidMovieTitle(){
        // should return invalid movie title error
        let error = interactor.validateMovieData(title: "", overview: "This is a random overview for a movie, this overview should be at least 50 words so bla bla bla bla bla bla", date: "2020-5-18")
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie title error
        XCTAssertEqual(error?.localizedDescription, Constants.Errors.invalidMovieTitle.localizedDescription)
    }
    
    // MARK: - Testing setting an invalid overview for a movie
    func testInvalidMovieOverview(){
        // should return invalid movie overview error
        let error = interactor.validateMovieData(title: "Movie Title", overview: "", date: "2020-5-18")
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie overview error
        XCTAssertEqual(error?.localizedDescription, Constants.Errors.invalidMovieOverview.localizedDescription)
    }
    
    // MARK: - Testing setting an invalid date for a movie
    func testInvalidMovieDate(){
        // should return invalid movie overview error
        let error = interactor.validateMovieData(title: "Movie Title", overview: "This is a random overview for a movie, this overview should be at least 50 words so bla bla bla bla bla bla", date: "")
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie date error
        XCTAssertEqual(error?.localizedDescription, Constants.Errors.invalidMovieDate.localizedDescription)
    }
    
    // MARK: - Testing setting a nil title for movie
    func testNilMovieTitle(){
        // should return invalid movie overview error
        let error = interactor.validateMovieData(title: nil, overview: "This is a random overview for a movie, this overview should be at least 50 words so bla bla bla bla bla bla", date: "2020-5-18")
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie title error
        XCTAssertEqual(error?.localizedDescription, Constants.Errors.invalidMovieTitle.localizedDescription)
    }
    
    // MARK: - Testing setting a nil overview for movie
    func testNilMovieOverview(){
        // should return invalid movie overview error
        let error = interactor.validateMovieData(title: "This is a movie title", overview: nil, date: "2020-5-18")
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie overview error
        XCTAssertEqual(error?.localizedDescription, Constants.Errors.invalidMovieOverview.localizedDescription)
    }
    
    // MARK: - Testing setting a nil overview for movie
    func testNilMovieDate(){
        // should return invalid movie date error
        let error = interactor.validateMovieData(title: "This is a movie title", overview: "This is a random overview for a movie, this overview should be at least 50 words so bla bla bla bla bla bla", date: nil)
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie date error
        XCTAssertEqual(error?.localizedDescription, Constants.Errors.invalidMovieDate.localizedDescription)
    }
    
    // MARK: - Testing setting a valid data for a movie
    func testValidMovieData(){
        // should return nil error
        let error = interactor.validateMovieData(title: "This is a movie title", overview: "This is a random overview for a movie, this overview should be at least 50 words so bla bla bla bla bla bla", date: "2020-5-18")
        // error should be nil
        XCTAssertNil(error)
    }
}
