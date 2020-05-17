//
//  MoviesCollectionViewCell.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    // MARK: - Labels and Background view
    // title label
    let title: UILabel = {
        let label = UILabel()
        label.text = "Movie"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    // overview label
    let overview: UILabel = {
        let label = UILabel()
        label.text = "overview"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0 //multi lines
        return label
    }()
    // date label
    let date: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        label.textColor = .systemTeal
        return label
    }()
    // poster image
    let poster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.image = UIImage(named: "placeholder")
        return image
    }()
    // cell setup
    override func awakeFromNib() {
        setUpCellView()
    }
    // MARK: - Setting up cell view
    private func setUpCellView() {
//        addSubview(bubbleBackground)
        addSubview(poster)
        addSubview(title)
        addSubview(date)
        addSubview(overview)
        setUpConstraints()
    }
    // MARK: - Setting constraints
    private func setUpConstraints(){
        // setting poster image constraints
        setPosterImageConstraints()
        // setting labels constraints
        setLabelsConstraints()
    }
    // MARK: - Image View Constraints
    private func setPosterImageConstraints(){
        poster.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        poster.widthAnchor.constraint(equalToConstant: 150).isActive = true
        poster.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    // MARK: - Labels constraints
    private func setLabelsConstraints() {
        // title
        title.topAnchor.constraint(equalTo: poster.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 16).isActive = true
        date.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        date.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        date.trailingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        // overview
        overview.topAnchor.constraint(equalTo: date.bottomAnchor).isActive = true
        overview.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        overview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        overview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}

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
