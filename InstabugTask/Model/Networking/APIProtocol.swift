//
//  APIProtocol.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/19/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

// MARK: - Protocol for API
// both mock APIClient and real APIClient should implement this protocol
protocol APIProtocol {
    func taskForAPIRequest(url: URL?, completionHandler: @escaping (Data?, Error?)->Void)
    func getMoviesList(url: URL?, completionHandler: @escaping (MoviesListResponse?, Error?)->Void)
}
