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
    private var interactor: MoviesInteractor! // interactor used to fetch movies list and posters
    private var client: APIProtocol! //client that conforms to API Protocol
    private weak var moviesDelegate: MoviesDelegate? // Movies delegate which is the movies view controller. The presenter should have access to the Movies Delegate protocol functions only
    private var allMovies: [Movie]{
        // whenever movies array is updated reload table view, this should be done in main queue as it is updating UIKit element
        didSet{
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    private var myMovies: [Movie] = []          // newly added movies
    private var currentPage = 1                 // current page instantiated to 1, used to keep track of page to be fetched when reaching end of table view
    
    // MARK: - Dependency Injection
    init(delegate: MoviesDelegate?, mockClient: APIProtocol?) {
        self.moviesDelegate = delegate
        allMovies = [] //instantiate all movies array
        // if no mock client passed then set it as TMDB client, this is used as to when testing Movies presenter we would be able to swap TMDB Client by the Mock Client
        if mockClient == nil{
            self.setTMDBClient()
        }else{
            self.setMockClient(client: mockClient!)
        }
        self.getMovies(pageNum: currentPage) // At initialization get movies in page 1
    }
    
    // MARK: - Set TMDB client
    // used at runtime when no mock client is set
    private func setTMDBClient(){
        self.client = APIClient()
        self.interactor = MoviesInteractor(client: client)
    }
    
    // MARK: setting Mock client type, used for testing
    private func setMockClient(client: APIProtocol) {
        self.interactor = MoviesInteractor(client: client)
    }
    
    // MARK: - update my movies list
    func updateMyMovies(){
        myMovies = MyMoviesModel.shared.getMovies()
        reloadData() // reload table veiw to show newly added movies
    }
    // MARK: - Reload data in table view
    func reloadData(){
        moviesDelegate?.updateData()
    }
    // MARK: - Get movies in specified page
    private func getMovies(pageNum: Int){
        // start animating loading indicator
        self.moviesDelegate?.showLoadingIndicator()
        interactor.getMoviesList(pageNum: pageNum, completionHandler: { [weak self] (movies, error) in
            guard error == nil else{
                // if this is unable to decode error, return without showing error, as this is an error caused from server timeout so it is not shown to user, instead the app tries to fetch data again
                if error?.localizedDescription == Errors.decodingError.localizedDescription{
                    return
                }
                // show other errors
                self?.moviesDelegate?.displayMessage(title: "Error", message: error!.localizedDescription)
                return
            }
            guard let movies = movies else{
                // make sure movies array is not nil, if it's nill hide loading indicator and show nil response error
                self?.moviesDelegate?.hideLoadingIndicator()
                self?.moviesDelegate?.displayMessage(title: "Error", message: Errors.nilResponseError.localizedDescription)
                return
            }
            // fetched movies successfully
            self?.allMovies += movies //append newly fetched movies
            self?.moviesDelegate?.hideLoadingIndicator() // hide loading indicator
            self?.reloadData() // reload collection view to update number of cells with movie data
            // after finishing get posters of each movie, Here I am loading the posters of each movie after fetching the title, date and overview of all the movies, this is better because if the connection is bad the user would be able to see the data while the posters load and get set on the background
            self?.getMoviesPosters(numberOfNewMovies: movies.count)
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
                self.interactor.getPosterImage(posterPath: self.allMovies[index].posterPath, completionHandler: { [weak self]
                    (image) in
                    // this image is never nil as interactor makes sure to set it either to placeholder or fetched image
                    self?.allMovies[index].poster = image //update movie poster
                })
            }
        }
    }
    // MARK: - Fetch New Page Movies
    func fetchNewPageMovies(){
        currentPage += 1 // update current page
        getMovies(pageNum: currentPage) //fetch movies of new page
    }
    // MARK: - Get number of all movies available
    func getMoviesCount()->Int{
        return allMovies.count
    }
    // MARK: - Get number of movies in my movies section
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
            // in my movies section
            let title = myMovies[indexPath.row].title
            let date = myMovies[indexPath.row].date.description
            let overview = myMovies[indexPath.row].overview
            let poster = myMovies[indexPath.row].poster
            updateCell(cell: cell, title: title, date: date, overview: overview, image: poster!)
        }else{
            // in all movies section
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
