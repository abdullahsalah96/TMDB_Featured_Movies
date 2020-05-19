//
//  MoviesInteractorTests.swift
//  InstabugTaskTests
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import XCTest
@testable import InstabugTask

class MoviesInteractorTests: XCTestCase {    
    private let interactor: MoviesInteractor = {
        let client = APIClient()
        return MoviesInteractor(client: client)
    }()
    // MARK: - Testing getting movies for a valid page number
    func testvalidMoviesList(){
        // error should be nil and movies list should not be nil
        let succesExcpectation = expectation(description: "Success")
        interactor.getMoviesList(pageNum: 1, completionHandler: {
            (movies, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(movies)
            succesExcpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    // MARK: - Testing getting movies for an invalid page number
    func testInvalidMoviesList(){
        // error should be nil and movies list should not be nil
        let errorExcpectation = expectation(description: "error")
        interactor.getMoviesList(pageNum: 999, completionHandler: {
            (movies, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(movies)
            errorExcpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Testing getting poster for invalid path
    func testInvalidPosterPath(){
        // Image should not be nil as it must have a value either fetched poster or placeholder image
        let successExcpectation = expectation(description: "Success")
        interactor.getPosterImage(posterPath: "sss", completionHandler: {
            (image) in
            XCTAssertNotNil(image)
            // image should be equal to placeholder image
            XCTAssertTrue(image.isEqualToImage(image: Constants.Images.placeholderImage!))
            successExcpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    // MARK: - Testing getting poster for valid path
    func testValidPosterPath(){
        // Image should not be nil as it must have a value which is not equal to placeholder image
        let successExcpectation = expectation(description: "Success")
        // this movie poster path is obtained by testing api an availabel poster path
        interactor.getPosterImage(posterPath: "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg", completionHandler: {
            (image) in
            XCTAssertNotNil(image)
            // image should be equal to placeholder image
            XCTAssertFalse(image.isEqualToImage(image: Constants.Images.placeholderImage!))
            successExcpectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
}
