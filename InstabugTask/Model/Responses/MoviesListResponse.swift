//
//  MovieResponse.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

struct MoviesListResponse: Codable{
    let page: Int
    let results: [MovieResponse]
    let totalResults: Int?
    let totalPages:Int?
    
    enum codingKeys: String, CodingKey{
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
