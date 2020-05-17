//
//  MoviesInteractor.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

class MoviesInteractor{
    // custom error for nill responses
    private let nilResponseError = NSError(domain:"", code:999, userInfo:[ NSLocalizedDescriptionKey: "No new movies found"])
    
    // MARK: - Get list of movies
    func getMoviesList(pageNum: Int, completionHandler: @escaping ([Movie]?, Error?)->Void){
        //fetch data
        Client.taskForGETRequest(url: Endpoints.getMoviesList(pageNum).url, responseType: MovieResponse.self, completionHandler: {
            (response, error) in
            guard error == nil else{
                // error fetching data
                completionHandler(nil, error)
                return
            }
            guard response != nil else{
                // nill response
                completionHandler(nil, self.nilResponseError)
                return
            }
            //fetched successfully
            guard response != nil else{
                // nill response
                completionHandler(nil, self.nilResponseError)
                return
            }
            //fetched successfully
            completionHandler(response?.results, nil)
        })
    }
    // MARK: - Get poster images
    func getPosterImage(posterPath: String, completionHandler: @escaping (Data?, Error?)->Void){
        let url = Endpoints.getMoviePoster(posterPath).url
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response, error) in
            guard error == nil else{
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            //fetched images successfully
            DispatchQueue.main.async {
                completionHandler(data, nil)
            }
        })
        task.resume()
    }
}
