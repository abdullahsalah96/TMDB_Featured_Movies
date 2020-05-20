//
//  MovieResponse.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

// MARK: - API Movies List response
// This is the response returned from the server which contains all movies data
struct MoviesListResponse: Codable{
    let page: Int
    let results: [MovieResponse] // array of of movie responses
    let totalResults: Int?
    let totalPages:Int?
    //coding keys to match keys with ones returned from API
    enum codingKeys: String, CodingKey{
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
