//
//  MoviesPresenterTests.swift
//  InstabugTaskTests
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import XCTest
@testable import InstabugTask

class MoviesPresenterTests: XCTestCase {
    //presenter to test
    private var presenter: MoviesPresenter = {
        let client = MockAPIClient()
        return MoviesPresenter(delegate: nil, mockClient: client)
    }()
    // MARK: - Test fetching new Movies
    // movies count should be greater than 0
    func testFetchingNewMovies(){
        presenter.fetchNewPageMovies()
        // expectation to wait for 5 seconds before checking movies count
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        if result == XCTWaiter.Result.timedOut {
            let moviesCount = presenter.getMoviesCount()
            // count should not be equal to 0
            print(moviesCount)
            XCTAssertNotEqual(moviesCount, 0)
        } else {
            XCTFail("Delay interrupted")
        }
    }
    
    // MARK: - Test My movies Array count
    // should be equal to 0 since no movie added
    func testGettingEmptyMyMovies(){
        let myMoviesCount = presenter.getMyMoviesCount()
        XCTAssertEqual(myMoviesCount, 0)
    }
    
    // MARK: - Test My movies array count after adding movie
    func testNonEmptyMyMovies(){
        let addMoviesInteractor = AddMovieInteractor()
        for _ in 1...20{
            _ = addMoviesInteractor.addNewMovie(title: "This is movie title", overview: "This is a random overview for a movie, this overview should be at least 30 letters so bla bla bla bla bla bla", date: Date(), image: Images.placeholderImage)
            presenter.updateMyMovies() // update my movies list
            // count of my movies available in presenter
            let myMoviesCount = presenter.getMyMoviesCount()
            // count of my movies available in Movie Model
            let modleMoviesCount = MyMoviesModel.shared.getMovies().count
            XCTAssertEqual(myMoviesCount, modleMoviesCount)
        }
        MyMoviesModel.shared.clearMyMoviesList() //clear list to prevent it affecting other tests
    }
}
