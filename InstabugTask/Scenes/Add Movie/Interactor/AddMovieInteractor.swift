//
//  AddMovieInteractor.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

class AddMovieInteractor{
    // MARK: - Validate Movie Data
    private func validateMovieData(title: String, overview: String, date: String)->Error?{
        // date formatter
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        if dateFormatterGet.date(from: date) == nil {
            // invalid format
            return Errors.invalidMovieDate
        }
        else if title.count < Constants.MinimumNewMovieData.minimumTitleCharacters{
            //make sure movie title string contains more than minimum title characters
            return Errors.invalidMovieTitle
        }else if overview.count < Constants.MinimumNewMovieData.minimumOverviewCharacters{
            //make sure movie overview string contains more than minimum overview characters
            return Errors.invalidMovieOverview
        }else{
            // no errors
            return nil
        }
    }
    // MARK: - Add new movie
    func addNewMovie(title: String?, overview: String?, date: Date?, image: UIImage?)->Error?{
        // init image to be placeholder image
        var posterImage = Images.placeholderImage
        // check that entries are not nil
        guard let title = title else{
            // make sure title is not nil
            return Errors.invalidMovieTitle
        }
        guard let overview = overview else {
            // make sure overview is not nil
            return Errors.invalidMovieOverview
        }
        guard let date = date else {
            // make sure date is not nil
            return Errors.invalidMovieDate
        }
        if image != nil{
            // if image is not nil set it
            posterImage = image
        }
        // date formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        // validate entries
        if let error = validateMovieData(title: title, overview: overview, date: dateString){
            // return error
            return error
        }else{
            // no error
            // check if movie exists
            let movie = Movie(title: title, date: dateString, overview: overview, poster: posterImage, posterPath: nil)
            if checkIfMovieExists(movieToCheck: movie){
                // movie exists
                // return error
                return Errors.movieExistsError
            }else {
                // movie doesn't exist
                // add it
                MyMoviesModel.shared.addMovie(movie: movie)
            }
            // return nil as there is no error
            return nil
        }
    }
    
    // MARK: - Check if movie already exists
    private func checkIfMovieExists(movieToCheck: Movie)->Bool{
        // loop through all my movies
        for movie in MyMoviesModel.shared.getMovies(){
            // check title, overview and data
            if (movieToCheck.title == movie.title) && (movieToCheck.date == movie.date) && (movieToCheck.overview == movie.overview){
                // movie already exists
                return true
            }
        }
        // movie doesn't exist return false
        return false
    }
    
}
