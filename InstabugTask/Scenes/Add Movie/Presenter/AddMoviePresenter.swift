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
        // validate entries
        if let error = interactor.validateMovieData(title: title, overview: overview, date: date){
            addMoviesDelegate?.displayMessage(title: "Error", message: error)
        }else{
            // add movie
            let movie = MyMovie(title: title, date: date, overview: overview, poster: image)
            MovieModel.addMovie(movie: movie)
            addMoviesDelegate?.displayMessage(title: "Success", message: "Movie Added Successfully")
        }
    }
    
}
