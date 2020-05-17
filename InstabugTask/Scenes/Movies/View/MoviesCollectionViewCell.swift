//
//  MoviesCollectionViewCell.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    // MARK: - Labels and Background view
    // title label
    let title: UILabel = {
        let label = UILabel()
        label.text = "Movie"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    // overview label
    let overview: UILabel = {
        let label = UILabel()
        label.text = "overview"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
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
    // Background view
    let bubbleBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let color = UIColor(red: 0.0235, green: 0.1215, blue: 0.3568, alpha: 0.91)
        view.backgroundColor = color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    // cell setup
    override func awakeFromNib() {
        setUpCellView()
    }
    // MARK: - Setting up cell view
    private func setUpCellView() {
        addSubview(bubbleBackground)
        addSubview(poster)
        addSubview(title)
        addSubview(date)
        addSubview(overview)
        setBackgroundShadow()
        setUpConstraints()
    }
    // MARK: - Setting constraints
    private func setUpConstraints(){
        // setting background constraints
        setBackgroundViewConstraints()
        // setting poster image constraints
        setPosterImageConstraints()
        // setting labels constraints
        setLabelsConstraints()
    }
    // MARK: - Background view constraints
    private func setBackgroundViewConstraints(){
        bubbleBackground.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        bubbleBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        bubbleBackground.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        bubbleBackground.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    // MARK: - Image View Constraints
    private func setPosterImageConstraints(){
        poster.topAnchor.constraint(equalTo: bubbleBackground.topAnchor, constant: 16).isActive = true
        poster.leadingAnchor.constraint(equalTo: bubbleBackground.leadingAnchor, constant: 16).isActive = true
        poster.bottomAnchor.constraint(equalTo: bubbleBackground.bottomAnchor, constant: -16).isActive = true
        poster.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    // MARK: - Labels constraints
    private func setLabelsConstraints() {
        // title
        title.topAnchor.constraint(equalTo: poster.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(equalTo: bubbleBackground.trailingAnchor, constant: -16).isActive = true
        // date
        date.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        date.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        date.trailingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        // overview
        overview.topAnchor.constraint(equalTo: date.bottomAnchor).isActive = true
        overview.leadingAnchor.constraint(equalTo: title.leadingAnchor).isActive = true
        overview.trailingAnchor.constraint(equalTo: title.trailingAnchor).isActive = true
        overview.bottomAnchor.constraint(equalTo: bubbleBackground.bottomAnchor, constant: -16).isActive = true
    }
    // MARK: - Setting up shadow for background view
    func setBackgroundShadow() {
        bubbleBackground.layer.shadowColor = UIColor.black.cgColor
        bubbleBackground.layer.shadowOffset = CGSize(width: 0, height: 1)
        bubbleBackground.layer.shadowOpacity = 0.4
        bubbleBackground.layer.shadowRadius = 1.0
        bubbleBackground.layer.masksToBounds = false
        bubbleBackground.clipsToBounds = false
    }
}

extension MoviesCollectionViewCell: MoviesCellDelegate{
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
