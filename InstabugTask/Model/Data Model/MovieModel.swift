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
    func addMovie(movie: Movie){
        self.myMovies.append(movie)
    }
    func getMovies()->[Movie]{
        return self.myMovies
    }
}
