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
//    private var presenter: MoviesPresenter!
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpView()
    }
    
    // MARK: - Setting Up UI
    private func setUpView(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
        collectionView!.collectionViewLayout = layout
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCollectionViewCell
        return cell
    }
    
    
}
