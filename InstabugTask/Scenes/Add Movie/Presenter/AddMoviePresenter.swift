//
//  AddMoviePresenter.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

protocol AddMovieDelegate: class{
    func displayMessage(title: String, message: String)
}

class AddMoviePresenter{
    // MARK: - Variables
    private weak var addMoviesDelegate: AddMovieDelegate?
    private let interactor =  AddMovieInteractor()
    // MARK: - Dependency injection
    init(delegate: AddMovieDelegate?) {
        self.addMoviesDelegate = delegate
    }
    //MARK: - Add new movie
    func addNewMovie(title: String, overview: String, date: Date, image: UIImage){
        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        // validate entries
        if let error = interactor.validateMovieData(title: title, overview: overview, date: dateString){
            addMoviesDelegate?.displayMessage(title: "Error", message: error)
        }else{
            // add movie
            let movie = Movie(title: title, date: dateString, overview: overview, poster: image, posterPath: nil)
            MovieModel.addMovie(movie: movie)
            addMoviesDelegate?.displayMessage(title: "Success", message: "Movie Added Successfully")
        }
    }
    
}
