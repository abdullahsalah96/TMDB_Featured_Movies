//
//  AddMovieTests+helpers.swift
//  InstabugTaskUITests
//
//  Created by Abdalla Elshikh on 5/20/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import XCTest

extension AddMovieTests{
    // MARK: - Helper function to get app elements
    func getElement()->XCUIElement{
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        return element
    }
    // MARK: - Helper function to navigate to Add Movies VC
    func navigateToAddMovies(){
        let button = app.buttons["Add"].firstMatch
        button.tap()
    }
}
