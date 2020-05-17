//
//  MovieModel.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

class MovieModel{
    private var myMovies: [Movie]
    static let shared = MovieModel() //singleton instance
    private init(){
        myMovies = []
    }
    static func addMovie(movie: Movie){
        shared.myMovies.append(movie)
    }
    static func getMovies()->[Movie]{
        return shared.myMovies
    }
}
