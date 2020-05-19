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
    // client, when service is up we could set it to API Client and not Mock API Client
    private let client: APIProtocol = {
        let client = MockAPIClient()
        return client
    }()
    // MARK: - Test invalid url
    // should throw error and response should be nil
    func testInvalidURL(){
        let errorExpectation = expectation(description: "Error Expectation")
        client.taskForAPIRequest(url: nil, completionHandler: {
            (response, error) in
            // invalid url so error is not nil
            XCTAssertNotNil(error)
            // error should be invalid url error
            XCTAssertEqual(error?.localizedDescription, Errors.invalidURLError.localizedDescription)
            //response is nil
            XCTAssertNil(response)
            errorExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test valid url
    // error should be nil and response not nil
    func testValidURL(){
        let errorExpectation = expectation(description: "Error Expectation")
        let url = Endpoints.getMoviesList(1).url
        client.taskForAPIRequest(url: url, completionHandler: {
            (response, error) in
            // valid url so error is nil
            XCTAssertNil(error)
            //response is not nil
            XCTAssertNotNil(response)
            errorExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test invalid page number
    // error shouldn't be nil and response should be nill
    func testInvalidPageNumber(){
        let errorExpectation = expectation(description: "Error Expectation")
        client.getMoviesList(pageNum: 999, completionHandler: {
            (response, error) in
            // error is not nil
            XCTAssertNotNil(error)
            // response should be nil
            XCTAssertNil(response)
            errorExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    // MARK: - Test valid url
    // error should be nil and response not nil
    func testValidMovieURL(){
        let successExpectation = expectation(description: "Success Expectation")
        client.getMoviesList(pageNum: 2, completionHandler: {
            (response, error) in
            // error should be nil
            XCTAssertNil(error)
            // response should not be nil
            XCTAssertNotNil(response)
            successExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    // MARK: - Test getting poster data
    // error should be nil and response should not be nill as even if poster path is invalid we will get response from api
    func testGetdPosterData(){
        let errorExpectation = expectation(description: "Error Expectation")
        let posterString = "ffff"
        client.gerPosterData(posterPath: posterString, completionHandler: {
            (response, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(response)
            errorExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
