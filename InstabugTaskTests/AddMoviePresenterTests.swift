//
//  AddMoviePresenterTests.swift
//  InstabugTaskTests
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.

import XCTest
@testable import InstabugTask

class AddMoviePresenterTests: XCTestCase{
    
    private let presenter = AddMoviePresenter(delegate: nil)
    // MARK: - Testing setting an invalid title for a movie
    func testInvalidMovieTitle(){
        // Movies in shared movie object count should be zeros as movie should not be added to movies array
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        let date = dateFormatterGet.date(from: "2020-11-20")
        presenter.addNewMovie(title: "", overview: "This is a random overview for a movie, this overview should be at least 50 words so bla bla bla bla bla bla", date: date!, image: Constants.Images.placeholderImage!)
        // movies count should be 0
        let movies = MovieModel.shared.getMovies()
        XCTAssertEqual(movies.count, 0)
    }
    // MARK: - Testing setting an invalid overview for a movie
    func testInvalidMovieOverview(){
        // Movies in shared movie object count should be zeros as movie should not be added to movies array
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        let date = dateFormatterGet.date(from: "2020-11-20")
        presenter.addNewMovie(title: "This is a movie title", overview: "", date: date!, image: Constants.Images.placeholderImage!)
        // movies count should be 0
        let movies = MovieModel.shared.getMovies()
        XCTAssertEqual(movies.count, 0)
    }
    // MARK: - Testing setting an invalid date format for a movie
    func testInvalidMovieDate(){
        // Movies in shared movie object count should be zeros as movie should not be added to movies array
        // date formatter
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        // make sure date is in a valid format
        let date = dateFormatterGet.date(from: "20-11-2011")
        presenter.addNewMovie(title: "", overview: "This is a random overview for a movie, this overview should be at least 50 words so bla bla bla bla bla bla", date: date!, image: Constants.Images.placeholderImage!)
        // movies count should be 0
        let movies = MovieModel.shared.getMovies()
        XCTAssertEqual(movies.count, 0)
    }
    // MARK: - Testing adding multiple valid movies
    func testValidMovieData(){
        // Movies in shared movie object count should be zeros as movie should not be added to movies array
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        let date = dateFormatterGet.date(from: "2020-11-20")
        for index in 1...20{
            presenter.addNewMovie(title: "This is a movie title", overview: "This is a random overview for a movie, this overview should be at least 50 words so bla bla bla bla bla bla", date: date!, image: Constants.Images.placeholderImage!)
            // movies count should be 0
            let movies = MovieModel.shared.getMovies()
            XCTAssertEqual(movies.count, index)
        }
    }
}
