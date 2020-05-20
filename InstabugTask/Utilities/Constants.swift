//
//  Colors.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.

import Foundation
import UIKit

struct Constants {
    // MARK: - Minimum new movie data
    struct MinimumNewMovieData {
        static let minimumTitleCharacters = 3 // movie title should have at least 3 characters
        static let minimumOverviewCharacters = 30 // movie overview should have at least 30 characters
    }
    // MARK: - default border radii
    struct BorderRadii {
        //default border radius used for buttons and textfields/views accross the app
        static let defaultBorderRadius = CGFloat(integerLiteral: 15)
    }
    // MARK: - Table view Data
    struct TableViewData {
        static let numberOfSections = 2
        static let myMoviesSection = 0
        static let allMoviesSection = 1
        static let heightForCell = CGFloat(integerLiteral: 150)
        static let heightForSectionHeader = CGFloat(integerLiteral: 50)
        static let myMoviesHeaderTitle = "My Movies"
        static let allMoviesHeaderTitle = "All Movies"
    }
}
