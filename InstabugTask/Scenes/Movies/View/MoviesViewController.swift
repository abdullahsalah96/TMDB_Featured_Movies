//
//  ViewController.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Outlets
    
    // MARK: - Variables
    private var presenter: MoviesPresenter!
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
    }
    // MARK: - View will appear
    // we need to instantiate presenter here to update my movies list after adding new movie
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = MoviesPresenter(delegate: self)
    }
    // MARK: - Setting Up UI
    private func setUpView(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMoviePressed))
    }
    // MARK: - Setting Up Collection view
    private func setUpTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    // MARK: - Add New Movie pressed
    @objc private func addMoviePressed(){
        presenter.addNewMovie()
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // MARK: - Section headers
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getHeaderView(section: section)
    }
    // MARK: - Setting section header view
    func getHeaderView(section: Int)->UIView{
        let label = HeaderLabel()
        if section == 0{
            label.text = "My Movies"
        }else{
            label.text = "All Movies"
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        let containerView = UIView()
        containerView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        return containerView
    }
    // MARK: - Height for section header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    // MARK: - Detecting when reached last cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == presenter.getMoviesCount()-1) {
           //Load more data & reload collection view
            presenter.fetchNewPageMovies()
         }
    }
    // MARK: - Number of movies in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // my movies section
            return presenter.getMyMoviesCount()
        }else{
            // all movies section
            return presenter.getMoviesCount()
        }
    }
    // MARK: - Height for each table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    // MARK: - View for each section
    // MARK: - Setting cell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell") as! MoviesTableViewCell
        presenter.setCellData(cell: cell, indexPath: indexPath)
        return cell
    }
}

extension MoviesViewController: MoviesDelegate{
    // MARK: - Show Loading Indicator
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    // MARK: - Hide Loading Indicator
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    // MARK: - Show Error
    func displayMessage(title: String, message: String) {
        showAlert(title: title, message: message)
    }
    // MARK: - Reload collection view
    func updateData() {
        tableView.reloadData()
    }
    // MARK: - Navigate to Adding Movie controller
    func navigateToAddMovieController() {
        let vc = storyboard?.instantiateViewController(identifier: "AddMovieViewController") as! AddMovieViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
