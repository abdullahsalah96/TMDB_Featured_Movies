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
    let mockURL = Endpoints.baseURL //used as mock url, so url passed should be equal to it
    let mockMovieResponse = MovieResponse(posterPath: "/xBHvZcjRiWyobQ9kxBhO6B2dtRI.jpg", adult: false, overview: "The near future, a time when both hope and hardships drive humanity to look to the stars and beyond", releaseDate: "2019-09-17", genreIds: [18,2], id: 419, originalTitle: "Mock movie title", originalLanguage: "EN", title: "Mock movie title", backdropPath: "/5BwqwxMEjeFtdknRV792Svo0K1v.jpg", popularity: 3, voteCount: 4, video: false, voteAverage: 50)
    
    let mockMoviesListResponse: MoviesListResponse
    
    init() {
        mockMoviesListResponse = MoviesListResponse(page: 1, results: [self.mockMovieResponse], totalResults: 1, totalPages: 1)
    }
}

extension MockAPIClient: APIProtocol{
    // MARK: - API Request for url
    func taskForAPIRequest(url: URL?, completionHandler: @escaping (Data?, Error?)->Void){
        // check if url is not nil
        guard let url = url else {
            DispatchQueue.main.async {
                completionHandler(nil, Constants.Errors.invalidURLError)
            }
            return
        }
        // check if url is equal to mock url
        if url != Endpoints.getBaseURL.url {
            DispatchQueue.main.async {
                completionHandler(nil, Constants.Errors.invalidURLError)
            }
        }
        // url is valid then return any data
        let dataString = "This is a random data returned by mock API Client"
        let data = Data(dataString.utf8)
        DispatchQueue.main.async {
            completionHandler(data, nil)
        }
        sleep(1)
    }
    // MARK: - Get Movies List
    func getMoviesList(url: URL?, completionHandler: @escaping (MoviesListResponse?, Error?)->Void){
        print("CAAALLED")
        // change getMoviesListWasCalled to true
        taskForAPIRequest(url: url, completionHandler: {
            (data, error) in
            // make sure error is nil
            guard error == nil else{
                DispatchQueue.main.async {
                    completionHandler(nil, error!)
                }
                return
            }
            // if error is nil then make sure we got data from API
            guard data != nil else{
                DispatchQueue.main.async {
                    completionHandler(nil, Constants.Errors.nilResponseError)
                }
                return
            }
            // if there is data then send mock api response
            DispatchQueue.main.async {
                completionHandler(self.mockMoviesListResponse, nil)
            }
        })
    }
}
