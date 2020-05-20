//
//  Movie.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

struct Movie{
    // This is a struct that encapsulates data ofeach movie
    // movie title
    let title: String
    // movie date
    let date: String
    // overview of movie
    let overview:String
    // movie poster
    var poster: UIImage?
    // poster path for fetched movies
    let posterPath: String?
}
