//
//  APIProtocol.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/19/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

// MARK: - Protocol for API
// both Mock APIClient (for testing) and real APIClient should implement this protocol
protocol APIProtocol {
    func taskForAPIRequest(url: URL?, completionHandler: @escaping (Data?, Error?)->Void) //API Request
    func getMoviesList(pageNum: Int, completionHandler: @escaping (MoviesListResponse?, Error?)->Void) //fetch movies from API
    func gerPosterData(posterPath: String?, completionHandler: @escaping (Data?, Error?)->Void) // get poster data of a certain movie
}
