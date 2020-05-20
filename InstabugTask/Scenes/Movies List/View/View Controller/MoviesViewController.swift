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
    // MARK: - View did load
    // initialize data
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        presenter = MoviesPresenter(delegate: self, mockClient: nil) // initialize presenter
    }
    // MARK: - View will appear
    // when view is about to appear, update my movies list to contain newly added movies
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
        //styling
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = Colors.primaryBlue
        // setting constraints using auto layout
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Paddings.smallPadding).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Paddings.smallPadding).isActive = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    // MARK: - Setting Up Table view
    private func setUpTableView(){
        tableView.backgroundColor = Colors.primaryDark
        tableView.dataSource = self
        tableView.delegate = self
    }
    // MARK: - Setting Up navigation bar
    private func setUpNavigationBar(){
        // styling
        navigationItem.title = "Movies"
        navigationController?.navigationBar.backgroundColor = Colors.primaryDark
        navigationController?.navigationBar.barTintColor = Colors.primaryDark
        navigationController?.navigationBar.tintColor = Colors.primaryBlue
        navigationController?.navigationBar.isTranslucent = false
        // adding Add movies button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMoviePressed))
    }
    // MARK: - Add New Movie pressed
    @objc private func addMoviePressed(){
        presenter.navigateToAddMovieController()
    }
}
