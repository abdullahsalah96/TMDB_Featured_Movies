//
//  Endpoints.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

enum Endpoints{
    //API KEY
    static let apiKey = "acea91d2bff1c53e6604e4985b6989e2"
    // base URL for API
    static let baseURL = "https://api.themoviedb.org/3"
    // api key parameter
    static let apiKeyParam = "?api_key=\(Endpoints.apiKey)"
    // cases
    case getMoviesList(Int)
    case getMoviePoster(String)
    case addMovie
    //get url string
    var stringValue:String{
        switch self{
            case .getMoviesList(let pageNum):
                return Endpoints.baseURL + "/discover/movie" + Endpoints.apiKeyParam + "&page=\(pageNum)"
            case .getMoviePoster(let posterPath):
                return "https://image.tmdb.org/t/p/w500//\(posterPath)"
            case .addMovie:
                return ""
        }
    }
    //get url
    var url:URL {
        return URL(string: stringValue)!
    }
}
