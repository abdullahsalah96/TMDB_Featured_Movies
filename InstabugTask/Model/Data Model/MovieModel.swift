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
    private var myMovies: [MyMovie]
    static let shared = MovieModel() //singleton instance
    private init(){
        myMovies = []
    }
    class func addMovie(movie: MyMovie){
        shared.myMovies.append(movie)
    }
    class func getMovies()->[MyMovie]{
        return shared.myMovies
    }
}

struct MyMovie{
    let title: String
    let date: Date
    let overview:String
    let poster: UIImage
}
