//
//  MoviesPresenter.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

class MoviesPresenter{
    // MARK: - Variables
    private var interactor: MoviesInteractor!
    private var client: APIProtocol!
    private weak var moviesDelegate: MoviesDelegate?
    private var allMovies: [Movie]{
        // whenever movies array is updated reload table view, this should be done in main queue as it is updating UIKit element
        didSet{
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    private var myMovies: [Movie] = []          // newly added movies
    private var currentPage = 1                 // start at page 1
    
    // MARK: - Dependency Injection
    init(delegate: MoviesDelegate?, mockClient: APIProtocol?) {
        self.moviesDelegate = delegate
        // if no mock client passed then set it as TMDB client, this is used as to when testing Movies presenter we would be able to swap TMDB Client by our Mock Client
        allMovies = []
        if mockClient == nil{
            self.setTMDBClient()
        }else{
            self.setMockClient(client: mockClient!)
        }
        self.getMovies(pageNum: currentPage) // At initialization get movies in page 1
    }
    
    // MARK: - Set TMDB client
    private func setTMDBClient(){
        self.client = APIClient()
        self.interactor = MoviesInteractor(client: client)
    }
    
    // MARK: setting Mock client type, used for testing
    private func setMockClient(client: APIProtocol) {
        self.interactor = MoviesInteractor(client: client)
    }
    
    // MARK: - Get my movies list
    func updateMyMovies(){
        myMovies = MovieModel.shared.getMovies()
        reloadData()
    }
    // MARK: - Reload data
    func reloadData(){
        moviesDelegate?.updateData()
    }
    // MARK: - Get movies in specified page
    private func getMovies(pageNum: Int){
        // emptying new movies array so that it contains movies of new page only
        // start animating loading indicator
        self.moviesDelegate?.showLoadingIndicator()
        interactor.getMoviesList(pageNum: pageNum, completionHandler: {(movies, error) in
            guard error == nil else{
                self.moviesDelegate?.hideLoadingIndicator()
                self.moviesDelegate?.displayMessage(title: "Error", message: error!.localizedDescription)
                return
            }
            guard let movies = movies else{
                self.moviesDelegate?.hideLoadingIndicator()
                self.moviesDelegate?.displayMessage(title: "Error", message:Constants.Errors.nilResponseError.localizedDescription)
                return
            }
            // fetched movies successfully
            self.allMovies += movies //append newly fetched movies
            self.moviesDelegate?.hideLoadingIndicator() // hide loading indicator
            self.reloadData() // reload collection view to update number of cells with movie data
            //after finishing get posters of each movie
            self.getMoviesPosters(numberOfNewMovies: movies.count)
        })
    }
    // MARK: - Get poster images for movies
    private func getMoviesPosters(numberOfNewMovies: Int){
        let newMoviesStartIndex = abs(numberOfNewMovies - allMovies.count) //start index of new fetched image
        // loop through these new movies to update their poster image in another queue to avoid blocking ui
        let queue = DispatchQueue.global()
        queue.async {
            for index in newMoviesStartIndex...self.allMovies.count - 1{
                // get poster for each movie
                self.interactor.getPosterImage(posterPath: self.allMovies[index].posterPath!, completionHandler: {
                    (image) in
                    self.allMovies[index].poster = image //update movie poster
                })
            }
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
    func navigateToAddMovieController(){
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
            updateCell(cell: cell, title: title, date: date, overview: overview, image: poster!)
        }else{
            // fetched movies
            let movie = allMovies[indexPath.row]
            updateCell(cell: cell, title: movie.title, date: movie.date, overview: movie.overview, image: movie.poster!)
        }
    }
    // MARK: - Update collection view cell with given data
    private func updateCell(cell: MoviesCellDelegate?, title: String, date: String, overview: String, image: UIImage){
        cell?.displayTitle(title: title)
        cell?.displayDate(date: date)
        cell?.displayOverview(overview: overview)
        cell?.displayImage(image: image)
    }
}
