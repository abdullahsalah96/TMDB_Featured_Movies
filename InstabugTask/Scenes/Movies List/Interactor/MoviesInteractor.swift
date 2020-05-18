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
    // MARK: - Get list of movies
    func getMoviesList(pageNum: Int, completionHandler: @escaping ([MovieResponse]?, Error?)->Void){
        //fetch data
        APIClient.getMoviesList(url: Endpoints.getMoviesList(pageNum).url, completionHandler: {
            (response, error) in
            guard error == nil else{
                // error fetching data
                completionHandler(nil, error)
                return
            }
            //fetched successfully
            completionHandler(response?.results, nil)
        })
    }
    // MARK: - Get poster images
    func getPosterImage(posterPath: String, completionHandler: @escaping (UIImage?, Error?)->Void){
        let url = Endpoints.getMoviePoster(posterPath).url
        APIClient.taskForGetRequest(url: url, completionHandler: {
            (data, error) in
            // make sure error is nil
            guard error == nil else{
                completionHandler(nil, error)
                return
            }
            // fetched successfully
            let image = UIImage(data: data!)
            completionHandler(image, nil)
        })
    }
}
