//
//  Presenter+Delegates.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesDelegate: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func displayMessage(title: String, message: String)
    func updateData()
    func navigateToAddMovieController()
}

protocol MoviesCellDelegate: class {
    func displayTitle(title: String)
    func displayImage(image: UIImage)
    func displayDate(date: String)
    func displayOverview(overview: String)
}
