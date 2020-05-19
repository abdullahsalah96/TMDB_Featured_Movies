//
//  MoviesViewControllerDelegate.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

extension MoviesViewController: MoviesDelegate{
    // MARK: - Show Loading Indicator
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    // MARK: - Hide Loading Indicator
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    // MARK: - Show Error
    func displayMessage(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    // MARK: - Reload collection view
    func updateData() {
        tableView.reloadData()
    }
    // MARK: - Navigate to Adding Movie controller
    func navigateToAddMovieController() {
        let vc = storyboard?.instantiateViewController(identifier: Identifiers.addMovie) as! AddMovieViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
