//
//  UITableViewCell+Extension.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

extension MoviesTableViewCell: MoviesCellDelegate{
    // MARK: - Displaying Title
    func displayTitle(title: String) {
        self.title.text = title
    }
    // MARK: - Displaying poster
    func displayImage(image: UIImage) {
        self.poster.image = image
    }
    // MARK: - Displaying date
    func displayDate(date: String) {
        self.date.text = date
    }
    // MARK: - Displaying overview
    func displayOverview(overview: String) {
        self.overview.text = overview
    }
}
