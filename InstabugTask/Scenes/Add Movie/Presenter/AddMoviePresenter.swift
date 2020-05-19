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
    func addNewMovie(title: String?, overview: String?, date: Date?, image: UIImage?){
        let error = interactor.addNewMovie(title: title, overview: overview, date: date, image: image)
        guard error == nil else{
            // make sure error is not nil
            addMoviesDelegate?.displayMessage(title: "Error", message: error!.localizedDescription)
            return
        }
        // added successfully
        addMoviesDelegate?.displayMessage(title: "Success", message: "Movie Added Successfully")
    }
}
