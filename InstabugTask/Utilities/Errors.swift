//
//  Errors.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/19/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation

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
    static let invalidMovieTitle = NSError(domain:"", code:994, userInfo:[ NSLocalizedDescriptionKey: "Please Enter a Valid Movie Title. Movie Titles should be of at least \(Constants.MinimumNewMovieData.minimumTitleLetters) letters"])
    // invalid movie overview
    static let invalidMovieOverview = NSError(domain:"", code:995, userInfo:[ NSLocalizedDescriptionKey: "Please Enter a Valid Movie Overview. Overview should be of at least \(Constants.MinimumNewMovieData.minimumOverviewLetters) letters"])
    // invalid movie date
    static let invalidMovieDate = NSError(domain:"", code:996, userInfo:[ NSLocalizedDescriptionKey: "Please Enter a Valid Movie Date. Date should be in format (yyyy-MM-dd)"])
    // server error
    static let serverError = NSError(domain:"", code:997, userInfo:[ NSLocalizedDescriptionKey: "Server Error"])
    // decoding error
    static let decodingError = NSError(domain:"", code:998, userInfo:[ NSLocalizedDescriptionKey: "Unable to decode data"])
}
