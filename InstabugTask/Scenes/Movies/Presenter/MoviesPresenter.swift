//
//  MoviesPresenter.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesDelegate: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showError(error: String)
    func updateData()
    func navigateToAddMovieController()
}

protocol MoviesCellDelegate: class {
    func displayTitle(title: String)
    func displayImage(image: UIImage)
    func displayDate(date: String)
    func displayOverview(overview: String)
}

class MoviesPresenter{
    // MARK: - Variables
    private weak var moviesDelegate: MoviesDelegate?
    private let interactor =  MoviesInteractor()
    private var movies: [Movie] = []
    private var myMovies: [Movie] = []
    private var posters: [UIImage?] = []
    private var currentPage = 1
    // MARK: - Dependency Injection
    init(delegate: MoviesDelegate?) {
        self.moviesDelegate = delegate
        self.getMovies(pageNum: currentPage) // At initialization get movies in page 1
    }
    // MARK: - Get movies in specified page
    private func getMovies(pageNum: Int){
        //loading data
        self.moviesDelegate?.showLoadingIndicator()
        interactor.getMoviesList(pageNum: pageNum, completionHandler: {(response, error) in
            guard error == nil else{
                self.moviesDelegate?.hideLoadingIndicator()
                self.moviesDelegate?.showError(error: error!.localizedDescription)
                return
            }
            //No error in fetching data, start updating view
            guard response != nil else{
                self.moviesDelegate?.showError(error: error!.localizedDescription)
                return
            }
            // append new movies
            self.movies += response!
            //after finishing update table
            self.getPosterImages()
            self.moviesDelegate?.hideLoadingIndicator()
            self.moviesDelegate?.updateData() // reload table view to update number of cells
        })
    }
    // MARK: - Get poster images for movies
    private func getPosterImages(){
        //itterate through movies and populate posters array
        for movie in self.movies{
            interactor.getPosterImage(posterPath: movie.posterPath ?? "", completionHandler: {
                (imageData, error) in
                guard error == nil else{
                    self.moviesDelegate?.showError(error: error!.localizedDescription)
                    return
                }
                //fetched image successfully
                self.posters.append(UIImage(data: imageData!))
                self.moviesDelegate?.updateData() // reload table view to update poster
            })
        }
    }
    // MARK: - Fetch New Page Movies
    func fetchNewPageMovies(){
        currentPage += 1 // update current page
        getMovies(pageNum: currentPage)
    }
    // MARK: - Get number of movies available
    func getMoviesCount()->Int{
        return movies.count
    }
    func getMyMoviesCount()->Int{
        return myMovies.count
    }
    // MARK: - Navigate to add movies view controller
    func addNewMovie(){
        moviesDelegate?.navigateToAddMovieController()
    }
    // MARK: - Setting movie cell data
    func setCellData(cell: MoviesCellDelegate?, index: Int){
        //need to check if image is nill put placeholder image else update image
        let movie = movies[index]
        var img = UIImage(named: "placeholder")
        if posters.count > index {
            img = posters[index]
        }
        cell?.displayTitle(title: movie.title)
        cell?.displayDate(date: movie.releaseDate)
        cell?.displayOverview(overview: movie.overview)
        cell?.displayImage(image: img!)
    }
}
