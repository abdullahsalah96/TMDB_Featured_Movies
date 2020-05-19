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
    internal func taskForAPIRequest(url: URL?, completionHandler: @escaping (Data?, Error?)->Void){
        //make sure url is not nil
        guard url != nil else{
            completionHandler(nil, Errors.invalidURLError)
            return
        }
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            // call completion handler with fetched data
            completionHandler(data, error)
        })
        task.resume()
    }
    // MARK: - Get Movies List
    func getMoviesList(pageNum: Int, completionHandler: @escaping (MoviesListResponse?, Error?)->Void){
        let url = Endpoints.getMoviesList(pageNum).url
        taskForAPIRequest(url: url, completionHandler: {
            (data, error) in
            // make sure erorr is nil
            guard error == nil else{
                completionHandler(nil, error)
                return
            }
            // make sure data is not nil before decoding
            guard let data = data else{
                DispatchQueue.main.async {
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
                    completionHandler(nil, error)
                }
            }
        })
    }

    func gerPosterData(posterPath: String?, completionHandler: @escaping (Data?, Error?) -> Void) {
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
                    completionHandler(nil, error)
                }
                return
            }
            // no data fetched
            guard data != nil else{
                DispatchQueue.main.async {
                    completionHandler(nil, Errors.nilResponseError)
                }
                return
            }
            // fetched successfully
            DispatchQueue.main.async {
                completionHandler(data!, nil)
            }
        })
    }
    
}
