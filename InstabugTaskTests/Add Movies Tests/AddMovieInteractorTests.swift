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
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        let date = dateFormatterGet.date(from: "2020-11-20")
        let error = interactor.addNewMovie(title: "", overview: "This is a random overview for a movie, this overview should be at least 30 letters so bla bla bla bla bla bla", date: date, image: Images.placeholderImage)
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie title error
        XCTAssertEqual(error?.localizedDescription, Errors.invalidMovieTitle.localizedDescription)
        // my movies count should be equal to 0
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 0)
    }
    
    // MARK: - Testing setting an invalid overview for a movie
    func testInvalidMovieOverview(){
        // should return invalid movie overview error
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        let date = dateFormatterGet.date(from: "2020-11-20")
        let error = interactor.addNewMovie(title: "Movie Title", overview: "", date: date, image: Images.placeholderImage)
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie overview error
        XCTAssertEqual(error?.localizedDescription, Errors.invalidMovieOverview.localizedDescription)
        // my movies count should be equal to 0
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 0)
    }
    
    // MARK: - Testing setting an invalid date for a movie
    func testInvalidMovieDate(){
        // should return invalid movie date error
         let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        let date = dateFormatterGet.date(from: "")
        let error = interactor.addNewMovie(title: "Movie Title", overview: "This is a random overview for a movie, this overview should be at least 30 letters so bla bla bla bla bla bla", date: date, image: Images.placeholderImage)
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie date error
        XCTAssertEqual(error?.localizedDescription, Errors.invalidMovieDate.localizedDescription)
        // my movies count should be equal to 0
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 0)
    }
    
    // MARK: - Testing setting a nil title for movie
    func testNilMovieTitle(){
        // should return invalid movie title error
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        let date = dateFormatterGet.date(from: "2020-11-20")
        let error = interactor.addNewMovie(title: nil, overview: "This is a random overview for a movie, this overview should be at least 30 letters so bla bla bla bla bla bla", date: date, image: Images.placeholderImage)
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie title error
        XCTAssertEqual(error?.localizedDescription, Errors.invalidMovieTitle.localizedDescription)
        // my movies count should be equal to 0
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 0)
    }
    
    // MARK: - Testing setting a nil overview for movie
    func testNilMovieOverview(){
        // should return invalid movie overview error
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        let date = dateFormatterGet.date(from: "2020-11-20")
        let error = interactor.addNewMovie(title: "This is a movie title", overview: nil, date: date, image: Images.placeholderImage)
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie overview error
        XCTAssertEqual(error?.localizedDescription, Errors.invalidMovieOverview.localizedDescription)
        // my movies count should be equal to 0
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 0)
    }
    
    // MARK: - Testing setting a nil overview for movie
    func testNilMovieDate(){
        // should return invalid movie date error
        let error = interactor.addNewMovie(title: "This is a movie title", overview: "This is a random overview for a movie, this overview should be at least 30 letters so bla bla bla bla bla bla", date: nil, image: Images.placeholderImage)
        // error not nil
        XCTAssertNotNil(error)
        // error is equal to invalid movie date error
        XCTAssertEqual(error?.localizedDescription, Errors.invalidMovieDate.localizedDescription)
        // my movies count should be equal to 0
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 0)
    }
    
    // MARK: - Testing setting a nil poster for movie
    func testNilMoviePoster(){
        // should return nil error as image is set to be placeholder
        let error = interactor.addNewMovie(title: "This is a movie title", overview: "This is a random overview for a movie, this overview should be at least 30 letters so bla bla bla bla bla bla", date: Date(), image: nil)
        // error is nil
        XCTAssertNil(error)
        // my movies count should be equal to 1
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 1)
        MyMoviesModel.shared.clearMyMoviesList()
    }
    
    // MARK: - Testing setting a valid data for a movie
    func testValidMovieData(){
        // should return nil error
        // formatting date
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let date = dateFormatterGet.date(from: "2020-11-20")
        let error = interactor.addNewMovie(title: "This is a movie title", overview: "This is a random overview for a movie, this overview should be at least 30 letters so bla bla bla bla bla bla", date: date, image: Images.placeholderImage)
        // error should be nil
        XCTAssertNil(error)
        // my movies count should be equal to 1
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 1)
        MyMoviesModel.shared.clearMyMoviesList()
    }
    
    // MARK: - Testing adding movie again after it has been added
    func testAddingSameMovie(){
        // should return movie exists error
        // formating date
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        let date = dateFormatterGet.date(from: "2020-11-20")
        let error = interactor.addNewMovie(title: "This is a movie title", overview: "This is a random overview for a movie, this overview should be at least 30 letters so bla bla bla bla bla bla", date: date, image: Images.placeholderImage)
        // error should be nil
        XCTAssertNil(error)
        // my movies count should be equal to 1
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 1)
        // trying to add same movie again
        let error2 = interactor.addNewMovie(title: "This is a movie title", overview: "This is a random overview for a movie, this overview should be at least 30 letters so bla bla bla bla bla bla", date: date, image: Images.placeholderImage)
        // error should not be nil
        XCTAssertNotNil(error2)
        // error should be equal to movie exists error
        XCTAssertEqual(error2?.localizedDescription, Errors.movieExistsError.localizedDescription)
        // my movies count should be equal to 1
        XCTAssertEqual(MyMoviesModel.shared.getMovies().count, 1)
        MyMoviesModel.shared.clearMyMoviesList()
    }
}
