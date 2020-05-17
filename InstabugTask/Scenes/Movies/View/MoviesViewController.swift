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
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Variables
    private var presenter: MoviesPresenter!
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpCollectionView()
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
    private func setUpCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        setUpCollectionViewSpacing()
    }
    //MARK: - Collection view spacing
    func setUpCollectionViewSpacing(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: width/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 16)
        collectionView!.collectionViewLayout = layout
    }
    // MARK: - Add New Movie pressed
    @objc private func addMoviePressed(){
        presenter.addNewMovie()
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: - Number of Sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    // MARK: - Section headers
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        setUpHeaderView(view: &view)
        if indexPath.section == 0{
            view.setSectionName(name: "My Movies")
        }else{
            view.setSectionName(name: "All Movies")
        }
        return view
    }
    // MARK: - Setting section header view
    func setUpHeaderView(view: inout SectionHeader){
        let width = 100
        let height = 30
        view.backgroundColor = .systemTeal
        view.layer.cornerRadius = CGFloat(height / 2)
        view.layer.borderColor = UIColor.black.cgColor
        view.frame = CGRect(x:Int(UIScreen.main.bounds.width/2) - width/2, y: 0, width:width, height:height)
    }
    // MARK: - Detecting when reached last cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == presenter.getMoviesCount()-1) {
           //Load more data & reload collection view
            presenter.fetchNewPageMovies()
         }
    }
    // MARK: - Number of movies in each section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            // my movies section
            return presenter.getMyMoviesCount()
        }else{
            // all movies section
            return presenter.getMoviesCount()
        }
    }
    // MARK: - Setting cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCollectionViewCell
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
        collectionView.reloadData()
    }
    // MARK: - Navigate to Adding Movie controller
    func navigateToAddMovieController() {
        let vc = storyboard?.instantiateViewController(identifier: "AddMovieViewController") as! AddMovieViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
