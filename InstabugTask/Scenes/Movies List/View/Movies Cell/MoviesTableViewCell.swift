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
        label.font = Constants.Fonts.primaryBold
        label.textColor = .white
        return label
    }()
    // overview label
    let overview: UILabel = {
        let label = UILabel()
        label.text = "overview"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.primaryRegular
        label.textColor = .white
        label.numberOfLines = 0 //multi lines
        return label
    }()
    // date label
    let date: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.primaryItalic
        label.textColor = Constants.Colors.primaryBlue
        return label
    }()
    // poster image
    let poster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
        image.image = Constants.Images.placeholderImage
        return image
    }()
    // cell setup
    override func awakeFromNib() {
        setUpCellView()
    }
    // MARK: - Setting up cell view
    private func setUpCellView() {
        backgroundColor = Constants.Colors.primaryDark
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
        poster.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Padding.defaultPadding).isActive = true
        poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Padding.defaultPadding).isActive = true
        poster.widthAnchor.constraint(equalToConstant: 150).isActive = true
        poster.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.Padding.defaultPadding).isActive = true
    }
    // MARK: - Labels constraints
    private func setLabelsConstraints() {
        // title
        title.topAnchor.constraint(equalTo: poster.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: Constants.Padding.defaultPadding).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Padding.defaultPadding).isActive = true
        date.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        date.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        date.trailingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        // overview
        overview.topAnchor.constraint(equalTo: date.bottomAnchor).isActive = true
        overview.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        overview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Padding.defaultPadding).isActive = true
        overview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.Padding.defaultPadding).isActive = true
    }
}
