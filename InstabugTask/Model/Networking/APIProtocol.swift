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
    func taskForAPIRequest(url: URL?, completionHandler: @escaping (Data?, Error?)->Void)
    func getMoviesList(pageNum: Int, completionHandler: @escaping (MoviesListResponse?, Error?)->Void)
    func gerPosterData(posterPath: String?, completionHandler: @escaping (Data?, Error?)->Void)

}
