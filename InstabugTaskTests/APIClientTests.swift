//
//  APIClientTests.swift
//  InstabugTaskTests
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import XCTest
@testable import InstabugTask

class APIClientTests: XCTestCase{
    // MARK: - Test invalid url
    // should throw error and response should be nil
    func testInvalidMovieURL(){
        let errorExpectation = expectation(description: "Error Expectation")
        let urlString = "////"
        let url = URL(string: urlString)
        APIClient.getMoviesList(url: url, completionHandler: {
            (response, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(response)
            errorExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    // MARK: - Test invalid page number
    // error shouldn't be nil and response should be nill
    func testInvalidPageNumber(){
        let errorExpectation = expectation(description: "Error Expectation")
        let url = Endpoints.getMoviesList(9999).url
        APIClient.getMoviesList(url: url, completionHandler: {
            (response, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(response)
            errorExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    // MARK: - Test valid url
    // error should be nil and response not nil
    func testValidMovieURL(){
        let successExpectation = expectation(description: "Success Expectation")
        let url = Endpoints.getMoviesList(1).url
        APIClient.getMoviesList(url: url, completionHandler: {
            (response, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            successExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    // MARK: - Test invalid poster path
    // error shouldn't be nil and response should be nill
    func testInvalidPosterURL(){
        let errorExpectation = expectation(description: "Error Expectation")
        let posterString = "ffff"
        let url = URL(string: posterString)
        APIClient.taskForGetRequest(url: url, completionHandler: {
            (response, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(response)
            errorExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    // MARK: - Test valid url
    // error should be nil and response not nil
    func testValidPosterURL(){
        // even though this url won't contain any images but we will get a valid response for this request
        // checking when url is not containing any images is in the interactor unit tests
        let successExpectation = expectation(description: "Success Expectation")
        let url = Endpoints.getMoviePoster("fff").url
        APIClient.taskForGetRequest(url: url, completionHandler: {
            (response, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            successExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: nil)
    }
}
