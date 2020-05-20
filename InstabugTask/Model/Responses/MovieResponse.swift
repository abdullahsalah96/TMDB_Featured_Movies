//
//  Movie.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Codable MovieResponse
// this struct is used to decode response of API, it contains each movies data. API Response will have an array of these movie responses
struct MovieResponse: Codable{
    let posterPath: String?
    let adult: Bool?
    let overview: String
    let releaseDate: String
    let genreIds: [Int]?
    let id: Int?
    let originalTitle: String?
    let originalLanguage: String?
    let title: String
    let backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?
    
    var releaseYear: String {
        return String(releaseDate.prefix(4))
    }
    //coding keys to match keys with ones returned from API
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}
