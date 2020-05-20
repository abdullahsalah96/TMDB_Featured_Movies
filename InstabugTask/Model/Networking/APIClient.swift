//
//  Client.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//
import Foundation

class APIClient: APIProtocol{
    // MARK: - API Request for url
    func taskForAPIRequest(url: URL?, completionHandler: @escaping (Data?, Error?)->Void){
        //make sure url is not nil
        guard url != nil else{
            // url is nil call completion handler with invalid url error
            completionHandler(nil, Errors.invalidURLError)
            return
        }
        //URL session data task
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            // call completion handler with fetched data
            // if data is nil it's checked in getMoviesList function and getPosterData function
            completionHandler(data, error)
        })
        task.resume()
    }
    // MARK: - Get Movies List
    func getMoviesList(pageNum: Int, completionHandler: @escaping (MoviesListResponse?, Error?)->Void){
        // get movies list api with for a certain page
        let url = Endpoints.getMoviesList(pageNum).url
        // call a request from server with this url
        taskForAPIRequest(url: url, completionHandler: {
            (data, error) in
            // make sure erorr is not nil
            guard error == nil else{
                DispatchQueue.main.async {
                    // error is not nill, call completion handler with server error
                    completionHandler(nil, Errors.serverError)
                }
                return
            }
            // make sure data is not nil before decoding
            guard let data = data else{
                DispatchQueue.main.async {
                    // data is nil call completion handler with nil response error
                    completionHandler(nil, Errors.nilResponseError)
                }
                return
            }
            do{
                let responseObject = try JSONDecoder().decode(MoviesListResponse.self, from: data)
                // decoded response successfully
                DispatchQueue.main.async {
                    completionHandler(responseObject, nil)
                }
            }catch{
                // error while decoding
                DispatchQueue.main.async {
                    completionHandler(nil, Errors.decodingError)
                }
            }
        })
    }

    func gerPosterData(posterPath: String?, completionHandler: @escaping (Data?, Error?) -> Void) {
        // if poster is nil send nil response error
        guard let posterPath = posterPath else{
            DispatchQueue.main.async {
                completionHandler(nil, Errors.nilResponseError)
            }
            return
        }
        let url = Endpoints.getMoviePoster(posterPath).url
        taskForAPIRequest(url: url, completionHandler: {
            (data, error) in
            // make sure error is nil
            guard error == nil else{
                DispatchQueue.main.async {
                    // call completion with server error
                    completionHandler(nil, Errors.serverError)
                }
                return
            }
            // no data fetched
            guard data != nil else{
                DispatchQueue.main.async {
                    // call completion handler with nil response error
                    completionHandler(nil, Errors.nilResponseError)
                }
                return
            }
            // fetched successfully
            DispatchQueue.main.async {
                // call completion handler with data
                completionHandler(data!, nil)
            }
        })
    }
    
}
