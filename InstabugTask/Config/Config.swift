//
//  Colors.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.

import Foundation
import UIKit

struct Config {
    struct Identifiers {
        static let movieCell = "MoviesCell"
        static let addMovie = "AddMovieViewController"
    }
    struct Colors {
        static let primaryDark = UIColor(white: 0.12, alpha: 1)
        static let primaryBlue = UIColor.systemTeal
    }
    struct Fonts{
        static let primaryBold: UIFont = .boldSystemFont(ofSize: 22)
        static let primaryRegular: UIFont = .systemFont(ofSize: 14)
        static let primaryItalic: UIFont = .italicSystemFont(ofSize: 14)
    }
    struct Padding {
        static let defaultPadding = CGFloat(integerLiteral: 16)
        static let doublePadding = CGFloat(integerLiteral: 32)
    }
    struct Errors {
        // custom error for nill responses
        static let nilResponseError = NSError(domain:"", code:999, userInfo:[ NSLocalizedDescriptionKey: "No new movies found"])
    }
    struct Images {
        static let placeholderImage = UIImage(named: "placeholder")
    }
    struct BorderRadii {
        static let defaultBorderRadius = CGFloat(integerLiteral: 15)
    }
}
