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
        else if title.count < Constants.MinimumNewMovieData.minimumTitleLetters{
            //make sure movie title string is larger than 3 words
            return Errors.invalidMovieTitle
        }else if overview.count < Constants.MinimumNewMovieData.minimumOverviewLetters{
            return Errors.invalidMovieOverview
        }else{
            // no errors
            return nil
        }
    }
    // MARK: - Add new movie
    func addNewMovie(title: String?, overview: String?, date: Date?, image: UIImage?)->Error?{
        var posterImage = Images.placeholderImage
        // check that entries are not nil
        guard let title = title else{
            return Errors.invalidMovieTitle
        }
        guard let overview = overview else {
            return Errors.invalidMovieOverview
        }
        guard let date = date else {
            return Errors.invalidMovieDate
        }
        if image != nil{
            posterImage = image
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        // validate entries
        if let error = validateMovieData(title: title, overview: overview, date: dateString){
            // return error
            return error
        }else{
            // check if movie exists
            let movie = Movie(title: title, date: dateString, overview: overview, poster: posterImage, posterPath: nil)
            if checkIfMovieExists(movieToCheck: movie){
                // movie exists
                return Errors.movieExistsError
            }else {
                // movie doesn't exist
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
