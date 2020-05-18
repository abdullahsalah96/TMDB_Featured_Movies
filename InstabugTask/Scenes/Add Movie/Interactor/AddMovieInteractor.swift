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
    func validateMovieData(title: String?, overview: String?, date: String?)->Error?{
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
        // date formatter
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        // make sure date is in a valid format
        if dateFormatterGet.date(from: date) == nil {
            // invalid format
            return Constants.Errors.invalidMovieDate
        }
        else if title.count < 3{
            //make sure movie title string is larger than 3 words
            return Constants.Errors.invalidMovieTitle
        }else if overview.count < 50{
            return Constants.Errors.invalidMovieOverview
        }else{
            // no errors
            return nil
        }
    }
}
