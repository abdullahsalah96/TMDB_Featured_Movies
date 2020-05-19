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
    
    private let client: APIProtocol
    init(client: APIProtocol) {
        self.client = client
    }
    // MARK: - Get list of movies
    func getMoviesList(pageNum: Int, completionHandler: @escaping ([Movie]?, Error?)->Void){
        //fetch data
        var allMovies:[Movie] = [] // movies array to be populated by fetched movies
        client.getMoviesList(pageNum: pageNum, completionHandler: {
            (response, error) in
            guard error == nil else{
                // error fetching data
                completionHandler(nil, error)
                return
            }
            // fetched successfully
            // convert movie list responses into array of movies in other queue to avoid blocking
            let queue = DispatchQueue.global()
            queue.async {
                // do in another queue
                for result in response!.results{
                    let movie = Movie(title: result.title, date: result.releaseDate, overview: result.overview, poster: Images.placeholderImage, posterPath: result.posterPath)
                    allMovies.append(movie)
                }
                //after finishing call completion handler in main queue
                DispatchQueue.main.async {
                    completionHandler(allMovies, nil)
                }
            }
        })
    }
    // MARK: - Get poster images
    func getPosterImage(posterPath: String, completionHandler: @escaping (UIImage)->Void){
        client.gerPosterData(posterPath: posterPath, completionHandler: {
            (data, error) in
            // make sure error is nil, if not set image to be placeholder image
            guard error == nil else{
                completionHandler(Images.placeholderImage!)
                return
            }
            // make sure data can be converted to image otherwise, image should be nil
            let img = UIImage(data: data!) ?? Images.placeholderImage
            completionHandler(img!)
        })
    }
}
