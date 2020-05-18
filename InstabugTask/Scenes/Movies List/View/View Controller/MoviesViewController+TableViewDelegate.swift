//
//  MoviesViewController+TableViewDelegate.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

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
        let label = TableViewHeaderLabel()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.movieCell) as! MoviesTableViewCell
        presenter.setCellData(cell: cell, indexPath: indexPath) // set cell data
        return cell
    }
}
