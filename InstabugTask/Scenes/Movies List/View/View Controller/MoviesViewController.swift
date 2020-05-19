//
//  ViewController.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Variables
    var presenter: MoviesPresenter!
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesPresenter(delegate: self, mockClient: nil)
        setUpView()
    }
    // MARK: - View will appear
    // we need to instantiate presenter here to update my movies list after adding new movie
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateMyMovies()
    }
    // MARK: - Setting Up UI
    private func setUpView(){
        view.backgroundColor = Colors.primaryDark
        setUpActivityIndicator()
        setUpTableView()
        setUpNavigationBar()
    }
    // MARK: - Setting up activity indicator
    private func setUpActivityIndicator(){
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = Colors.primaryBlue
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    // MARK: - Setting Up Collection view
    private func setUpTableView(){
        tableView.backgroundColor = Colors.primaryDark
        tableView.dataSource = self
        tableView.delegate = self
    }
    // MARK: - Setting Up navigation bar
    private func setUpNavigationBar(){
        navigationItem.title = "Movies"
        navigationController?.navigationBar.backgroundColor = Colors.primaryDark
        navigationController?.navigationBar.barTintColor = Colors.primaryDark
        navigationController?.navigationBar.tintColor = Colors.primaryBlue
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMoviePressed))
    }
    // MARK: - Add New Movie pressed
    @objc private func addMoviePressed(){
        presenter.navigateToAddMovieController()
    }
}
