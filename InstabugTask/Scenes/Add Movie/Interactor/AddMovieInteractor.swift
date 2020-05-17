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
    func validateMovieData(title: String, overview: String, date: Date)->String?{
        if title.count < 1{
            return "Please enter a valid movie title"
        }else if overview.count < 1{
            return "Please enter a valid movie overview"
        }else if date.description.count < 1{
            return "Please enter a valid movie date"
        }else{
            return nil
        }
    }
}
