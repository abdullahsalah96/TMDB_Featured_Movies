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
    private let client: APIProtocol //client that conforms toAPI Protocol 
    // Dependency Injection, this is used to be able to inject either TMBD API Client at runtime or Mock API Client at testing
    init(client: APIProtocol) {
        self.client = client
    }
    // MARK: - Get list of movies
    func getMoviesList(pageNum: Int, completionHandler: @escaping ([Movie]?, Error?)->Void){
        //fetch data
        var fetchedMovies:[Movie] = [] // movies array to be populated by fetched movies
        client.getMoviesList(pageNum: pageNum, completionHandler: {
            (response, error) in
            guard error == nil else{
                // error fetching data
                completionHandler(nil, error)
                return
            }
            // fetched successfully
            // convert movie list responses into array of movies in other queue to avoid blocking
            // Response is converted to this movie model to discard any unnecessary data as only movie title, date, overview, poster and poster path of the movie are of concern
            let queue = DispatchQueue.global()
            queue.async {
                // do in another queue
                for result in response!.results{
                    // loop through results and append fetched movies array
                    let movie = Movie(title: result.title, date: result.releaseDate, overview: result.overview, poster: Images.placeholderImage, posterPath: result.posterPath)
                    fetchedMovies.append(movie)
                }
                //after finishing call completion handler in main queue
                DispatchQueue.main.async {
                    completionHandler(fetchedMovies, nil)
                }
            }
        })
    }
    // MARK: - Get poster images
    func getPosterImage(posterPath: String?, completionHandler: @escaping (UIImage)->Void){
        client.gerPosterData(posterPath: posterPath, completionHandler: {
            (data, error) in
            // make sure error is nil, if not set image to be placeholder image
            // no error is thrown here as if there's an error fetching poster, placeholder image should be set instead of showing an error to the user
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
