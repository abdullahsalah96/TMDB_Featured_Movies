//
//  MovieModel.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Movie Model
// singleton shared object that contains array of added movies
class MyMoviesModel{
    private var myMovies: [Movie]
    static let shared = MyMoviesModel() //shared singleton instance
    private init(){
        myMovies = []
    }
    // MARK: - Add new movie to my movies list
    func addMovie(movie: Movie){
        self.myMovies.append(movie)
    }
    // MARK: - Get List of my movies
    func getMovies()->[Movie]{
        return self.myMovies
    }
    // MARK: - Clear My Movies list
    func clearMyMoviesList(){
        self.myMovies = []
    }
}
