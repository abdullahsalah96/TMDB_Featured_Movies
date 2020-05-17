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

class MoviesPresenter{
    // MARK: - Variables
    private weak var moviesDelegate: MoviesDelegate?
    private let interactor =  MoviesInteractor()
    private var allMovies: [Movie] = []     // all fetched movies
    private var movies: [Movie] = []        // movies fetched for each new page
    private var myMovies: [MyMovie] = []      // newly added movies
    private var myMoviesPosters: [UIImage?] = [] // posters of newly added movies
    private var posters: [UIImage?] = [] // all fetched movies' posters
    private var currentPage = 1
    // MARK: - Dependency Injection
    init(delegate: MoviesDelegate?) {
        self.moviesDelegate = delegate
        self.getMyMovies()
        self.getMovies(pageNum: currentPage) // At initialization get movies in page 1
    }
    // MARK: - Get my movies list
    private func getMyMovies(){
        myMovies = MovieModel.getMovies()
    }
    // MARK: - Get movies in specified page
    private func getMovies(pageNum: Int){
        //loading data
        self.moviesDelegate?.showLoadingIndicator()
        interactor.getMoviesList(pageNum: pageNum, completionHandler: {(response, error) in
            guard error == nil else{
                self.moviesDelegate?.hideLoadingIndicator()
                self.moviesDelegate?.displayMessage(title: "Error", message: error!.localizedDescription)
                return
            }
            //No error in fetching data, start updating view
            guard response != nil else{
                self.moviesDelegate?.displayMessage(title: "Error", message: error!.localizedDescription)
                return
            }
            // append new movies
            self.movies = response!
            self.allMovies += self.movies
            //after finishing update table
            self.getPosterImages()
            self.moviesDelegate?.hideLoadingIndicator()
            self.moviesDelegate?.updateData() // reload table view to update number of cells with movie data
        })
    }
    // MARK: - Get poster images for movies
    private func getPosterImages(){
        //itterate through movies and populate posters array
        for movie in self.movies{
            interactor.getPosterImage(posterPath: movie.posterPath ?? "", completionHandler: {
                (imageData, error) in
                guard error == nil else{
                    self.moviesDelegate?.displayMessage(title: "Error", message: error!.localizedDescription)
                    return
                }
                //fetched image successfully
                let img = UIImage(data: imageData!)!
                self.posters.append(img)
                self.moviesDelegate?.updateData() // reload table view to update poster
            })
        }
    }
    // MARK: - Fetch New Page Movies
    func fetchNewPageMovies(){
        currentPage += 1 // update current page
        getMovies(pageNum: currentPage)
    }
    // MARK: - Get number of all movies available
    func getMoviesCount()->Int{
        return allMovies.count
    }
    func getMyMoviesCount()->Int{
        return myMovies.count
    }
    // MARK: - Navigate to add movies view controller
    func addNewMovie(){
        moviesDelegate?.navigateToAddMovieController()
    }
    // MARK: - Setting movie cell data
    func setCellData(cell: MoviesCellDelegate?, indexPath: IndexPath){
        // check whether it's my movie section or fetched movies
        if indexPath.section == 0{
            // my movies
            let title = myMovies[indexPath.row].title
            let date = myMovies[indexPath.row].date.description
            let overview = myMovies[indexPath.row].overview
            let poster = myMovies[indexPath.row].poster
            updateCell(cell: cell, title: title, date: date, overview: overview, image: poster)
        }else{
            // fetched movies
            let movie = allMovies[indexPath.row]
            var img = UIImage(named: "placeholder")
            //need to check if image is nill put placeholder image else update image
            if posters.count > indexPath.row {
                img = posters[indexPath.row]
            }
            updateCell(cell: cell, title: movie.title, date: movie.releaseDate, overview: movie.overview, image: img!)
        }
    }
    
    private func updateCell(cell: MoviesCellDelegate?, title: String, date: String, overview: String, image: UIImage){
        cell?.displayTitle(title: title)
        cell?.displayDate(date: date)
        cell?.displayOverview(overview: overview)
        cell?.displayImage(image: image)
    }
}
