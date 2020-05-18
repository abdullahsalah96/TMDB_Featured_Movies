//
//  MoviesInteractorTests.swift
//  InstabugTaskTests
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import XCTest
@testable import InstabugTask

class MoviesInteractorTests: XCTestCase {
    
    func testInvalidMoviesList(){
        let interactor = MoviesInteractor()
        interactor.getMoviesList(pageNum: <#T##Int#>, completionHandler: <#T##([MovieResponse]?, Error?) -> Void#>)
    }
}
