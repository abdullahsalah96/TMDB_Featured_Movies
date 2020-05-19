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
        label.font = Fonts.primaryBold
        label.textColor = .white
        return label
    }()
    // overview label
    let overview: UITextView = {
        // movie overview is text view so users would be able to scroll to read the full movie overview instead of seeing a snippet of it
        let textVeiew = UITextView()
        textVeiew.text = "overview"
        textVeiew.translatesAutoresizingMaskIntoConstraints = false
        textVeiew.font = Fonts.primaryRegular
        textVeiew.textColor = .white
        textVeiew.isEditable = false
        textVeiew.backgroundColor = Colors.primaryDark
//        label.numberOfLines = 0 //multi lines
        return textVeiew
    }()
    // date label
    let date: UILabel = {
        let label = UILabel()
        label.text = "date"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =
            Fonts.primaryItalic
        label.textColor = Colors.primaryBlue
        return label
    }()
    // poster image
    let poster: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
        image.image = Images.placeholderImage
        return image
    }()
    // cell setup
    override func awakeFromNib() {
        setUpCellView()
    }
    // MARK: - Setting up cell view
    private func setUpCellView() {
        backgroundColor = Colors.primaryDark
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
        setTextConstraints()
    }
    // MARK: - Image View Constraints
    private func setPosterImageConstraints(){
        poster.topAnchor.constraint(equalTo: topAnchor, constant: Paddings.defaultPadding).isActive = true
        poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.defaultPadding).isActive = true
        poster.widthAnchor.constraint(equalToConstant: 150).isActive = true
        poster.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Paddings.defaultPadding).isActive = true
    }
    // MARK: - Labels constraints
    private func setTextConstraints() {
        // title
        title.topAnchor.constraint(equalTo: poster.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: Paddings.defaultPadding).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.defaultPadding).isActive = true
        date.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        date.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        date.trailingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        // overview
        // the constants in anchors to compensate for borders of text view
        overview.topAnchor.constraint(equalTo: date.bottomAnchor, constant: -Paddings.textViewTopPadding).isActive = true
        overview.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: -Paddings.textViewLeadingPadding).isActive = true
        overview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.defaultPadding).isActive = true
        overview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Paddings.defaultPadding).isActive = true
    }
}
