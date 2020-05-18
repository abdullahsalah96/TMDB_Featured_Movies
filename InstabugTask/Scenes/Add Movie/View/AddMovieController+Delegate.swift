//
//  AddMovieController+Delegate.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

extension AddMovieViewController: AddMovieDelegate{
    func displayMessage(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
}
