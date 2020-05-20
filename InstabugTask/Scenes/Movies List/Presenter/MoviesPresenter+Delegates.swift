//
//  Presenter+Delegates.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Movies Delegate
// This is the delegate protocol that the Movies View Controller should conform to
protocol MoviesDelegate: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func displayMessage(title: String, message: String)
    func updateData()
    func navigateToAddMovieController()
}
// MARK: - Movies Cell Delegate
// This is the delegate protocol that the Movies Cell should conform to
protocol MoviesCellDelegate: class {
    func displayTitle(title: String)
    func displayImage(image: UIImage)
    func displayDate(date: String)
    func displayOverview(overview: String)
}
