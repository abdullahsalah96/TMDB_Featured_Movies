//
//  AddMoviePresenter+Delegate.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/20/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

// MARK: - Add Movies Delegate
// This is the delegate protocol that the Add Movies View Controller should conform to
protocol AddMovieDelegate: class{
    func displayMessage(title: String, message: String)
}
