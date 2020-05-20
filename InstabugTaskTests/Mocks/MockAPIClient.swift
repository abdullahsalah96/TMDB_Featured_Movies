//
//  MockAPI.swift
//  InstabugTaskTests
//
//  Created by Abdalla Elshikh on 5/19/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
@testable import InstabugTask

class MockAPIClient{
    let mockURL =  Endpoints.getMoviesList(1).url //used as mock url, so url passed should be equal to it
    let mockPosterPath = "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg" // mock poster path
    // mock response
    let mockMovieResponse = MovieResponse(posterPath: "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg", adult: false, overview: "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond", releaseDate: "2019-09-17", genreIds: [18,2], id: 419, originalTitle: "Mock movie title", originalLanguage: "EN", title: "Mock movie title", backdropPath: "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg", popularity: 3, voteCount: 4, video: false, voteAverage: 50)
    let mockPagesNumber = 50 //we set this to be total page number, real api will send us this number
    let mockData = Data(count: 100) //mock data to be sent by api
    let mockMoviesListResponse: MoviesListResponse
    
    init() {
        mockMoviesListResponse = MoviesListResponse(page: 1, results: [self.mockMovieResponse], totalResults: 1, totalPages: 50)
    }
}
