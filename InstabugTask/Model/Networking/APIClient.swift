//
//  Client.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

class APIClient{
    // MARK: - GET Request
    class func taskForGetRequest(url: URL?, completionHandler: @escaping (Data?, Error?)->Void){
        //make sure url is not nil
        guard url != nil else{
            completionHandler(nil, Constants.Errors.invalidURLError)
            return
        }
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
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
                    completionHandler(nil, Constants.Errors.nilResponseError)
                }
                return
            }
            // fetched successfully
            DispatchQueue.main.async {
                completionHandler(data, nil)
            }
        })
        task.resume()
    }
    // MARK: - Get Movies List
    class func getMoviesList(url: URL?, completionHandler: @escaping (MoviesListResponse?, Error?)->Void){
        taskForGetRequest(url: url, completionHandler: {
            (data, error) in
            // make sure erorr is nil
            guard error == nil else{
                completionHandler(nil, error)
                return
            }
            // make sure data is not nil before decoding
            do{
                let responseObject = try JSONDecoder().decode(MoviesListResponse.self, from: data!)
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
}
