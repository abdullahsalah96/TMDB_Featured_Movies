//
//  AddMovieController+Delegate.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

// MARK: - Add movie delegate
extension AddMovieViewController: AddMovieDelegate{
    func displayMessage(title: String, message: String) {
        // display alert
        self.showAlert(title: title, message: message)
    }
}
