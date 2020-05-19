//
//  MockAPIClient+APIProtocol.swift
//  InstabugTaskTests
//
//  Created by Abdalla Elshikh on 5/19/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
@testable import InstabugTask

extension MockAPIClient: APIProtocol{
    // MARK: - API Request for url
    func taskForAPIRequest(url: URL?, completionHandler: @escaping (Data?, Error?) -> Void) {
        // check if url is valid
        guard url != nil else{
            completionHandler(nil, Errors.invalidURLError)
            return
        }
        // check if url is not equal to mock url
        if url != self.mockURL{
            //return invalid url error
            completionHandler(nil, Errors.invalidURLError)
            return
        }
        // url is valid then return random data
        let data = self.mockData
        completionHandler(data, nil)
        return
    }
    
    // MARK: - Get Movies List
    func getMoviesList(pageNum: Int, completionHandler: @escaping (MoviesListResponse?, Error?)->Void){
        // check if the page number is valid
        if pageNum > self.mockPagesNumber {
            //throw error
            completionHandler(nil, Errors.invalidPageError)
            return
        }
        // if it's valid page so we set url to mock url of api
        let url = self.mockURL
        // change getMoviesListWasCalled to true
        taskForAPIRequest(url: url, completionHandler: {
            (data, error) in
            // make sure error is nil
            guard error == nil else{
                completionHandler(nil, error!)
                return
            }
            // if error is nil then make sure we got data from API
            guard data != nil else{
                completionHandler(nil, Errors.nilResponseError)
                return
            }
            // if there is data then send mock api response
            completionHandler(self.mockMoviesListResponse, nil)
            return
        })
    }
    // MARK: - Get Poster for movie
    func gerPosterData(posterPath: String?, completionHandler: @escaping (Data?, Error?) -> Void) {
        // this should always return data as if poster path is API will return invalid path response
        let data = self.mockData
        // if posterPath is nil return error
        guard let posterPath = posterPath else{
            DispatchQueue.main.async {
                completionHandler(nil, Errors.nilResponseError)
            }
            return
        }
        guard posterPath == self.mockPosterPath else{
            completionHandler(data, nil)
            return
        }
        // poster path is valid, call task with mock url
        taskForAPIRequest(url: self.mockURL, completionHandler: {
            (data, error) in
            //should always return response as when url is invalid api returns invalid api response
            completionHandler(data, nil)
        })
    }
}
