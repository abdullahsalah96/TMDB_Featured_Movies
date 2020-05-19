//
//  Colors.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.

import Foundation
import UIKit

struct Constants {
    // MARK: - Storyboard identifiers
    struct Identifiers {
        static let movieCell = "MoviesCell"
        static let addMovie = "AddMovieViewController"
    }
    // MARK: - used colors
    struct Colors {
        static let primaryDark = UIColor(white: 0.12, alpha: 1)
        static let primaryBlue = UIColor.systemTeal
        static let primaryTextFields = UIColor.systemGray
        static let primaryLight = UIColor(white: 0.95, alpha: 1)
    }
    // MARK: - used fonts
    struct Fonts {
        static let primaryBold: UIFont = .boldSystemFont(ofSize: 22)
        static let primaryRegular: UIFont = .systemFont(ofSize: 14)
        static let primaryItalic: UIFont = .italicSystemFont(ofSize: 14)
    }
    // MARK: - paddings
    struct Padding {
        static let smallPadding = CGFloat(integerLiteral: 6)
        static let defaultPadding = CGFloat(integerLiteral: 16)
        static let doublePadding = CGFloat(integerLiteral: 32)
    }
    // MARK: - Minimum new movie data
    struct MinimumNewMovieData {
        static let minimumTitleLetters = 3
        static let minimumOverviewLetters = 30
    }
    // MARK: - custom errors
    struct Errors {
        // custom error for nill responses
        static let nilResponseError = NSError(domain:"", code:990, userInfo:[ NSLocalizedDescriptionKey: "No new movies found"])
        // invalid data error
        static let invalidResponseError = NSError(domain:"", code:991, userInfo:[ NSLocalizedDescriptionKey: "No new movies found"])
        // invalid URL error
        static let invalidURLError = NSError(domain:"", code:992, userInfo:[ NSLocalizedDescriptionKey: "Invalid URL"])
        // invalid page error
        static let invalidPageError = NSError(domain:"", code:993, userInfo:[ NSLocalizedDescriptionKey: "Invalid Page number"])
        // invalid movie title
        static let invalidMovieTitle = NSError(domain:"", code:994, userInfo:[ NSLocalizedDescriptionKey: "Please Enter a Valid Movie Title, Movie Titles should be of at least \(MinimumNewMovieData.minimumTitleLetters) letters"])
        // invalid movie overview
        static let invalidMovieOverview = NSError(domain:"", code:995, userInfo:[ NSLocalizedDescriptionKey: "Please Enter a Valid Movie Overview, Overview should be of at least \(MinimumNewMovieData.minimumOverviewLetters) letters"])
        // invalid movie date
        static let invalidMovieDate = NSError(domain:"", code:996, userInfo:[ NSLocalizedDescriptionKey: "Please Enter a Valid Movie Date, Date should be in format (yyyy-MM-dd)"])
    }
    // MARK: - Images
    struct Images {
        static let placeholderImage = UIImage(named: "placeholder")
        static let pressPlaceholderImage = UIImage(named: "pressImage")
        static let instabugLogo = UIImage(named: "instabugLogo")
        static let logo = UIImage(named: "logo")
    }
    // MARK: - default border radii
    struct BorderRadii {
        static let defaultBorderRadius = CGFloat(integerLiteral: 15)
    }
}
