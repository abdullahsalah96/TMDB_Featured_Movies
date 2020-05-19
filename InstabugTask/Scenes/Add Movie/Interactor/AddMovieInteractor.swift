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
            return Constants.Errors.invalidMovieDate
        }
        else if title.count < Constants.MinimumNewMovieData.minimumTitleLetters{
            //make sure movie title string is larger than 3 words
            return Constants.Errors.invalidMovieTitle
        }else if overview.count < Constants.MinimumNewMovieData.minimumOverviewLetters{
            return Constants.Errors.invalidMovieOverview
        }else{
            // no errors
            return nil
        }
    }
    
    func addNewMovie(title: String?, overview: String?, date: Date?, image: UIImage?)->Error?{
        var posterImage = Constants.Images.placeholderImage
        // check that entries are not nil
        guard let title = title else{
            return Constants.Errors.invalidMovieTitle
        }
        guard let overview = overview else {
            return Constants.Errors.invalidMovieOverview
        }
        guard let date = date else {
            return Constants.Errors.invalidMovieDate
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
            // add movie
            let movie = Movie(title: title, date: dateString, overview: overview, poster: posterImage, posterPath: nil)
            MovieModel.shared.addMovie(movie: movie)
            // return nil as there is no error
            return nil
        }
    }
}
