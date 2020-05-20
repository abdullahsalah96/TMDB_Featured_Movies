//
//  MoviesViewController+TableViewDelegate.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Table view delegate and data source
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource{
    // MARK: - Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.TableViewData.numberOfSections
    }
    // MARK: - Section headers
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getHeaderView(section: section)
    }
    // MARK: - Setting section header view to custom header
    func getHeaderView(section: Int)->UIView{
        let label = TableViewHeaderLabel() //custom table view section header
        if section == Constants.TableViewData.myMoviesSection{
            // in my movies section
            label.text = Constants.TableViewData.myMoviesHeaderTitle
        }else{
            // in all movies section
            label.text = Constants.TableViewData.allMoviesHeaderTitle
        }
        // setting constraints using auto layout
        label.translatesAutoresizingMaskIntoConstraints = false
        let containerView = UIView()
        containerView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        return containerView
    }
    // MARK: - Height for section header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.TableViewData.heightForSectionHeader
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
        if section == Constants.TableViewData.myMoviesSection {
            // my movies section
            return presenter.getMyMoviesCount()
        }else{
            // all movies section
            return presenter.getMoviesCount()
        }
    }
    // MARK: - Height for each table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableViewData.heightForCell
    }
    // MARK: - Setting cell data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            Identifiers.movieCell) as! MoviesTableViewCell
        presenter.setCellData(cell: cell, indexPath: indexPath) // set cell data
        return cell
    }
}
