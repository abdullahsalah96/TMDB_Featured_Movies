//
//  SectionHeader.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    let sectionName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .systemGray6
        return label
    }()
    
    override func awakeFromNib() {
        setUpView()
        addSubview(sectionName)
        setUpConstraints()
    }
    
    func setUpView(){
        layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .systemGray
        layer.masksToBounds = true
        layer.cornerRadius = 15
    }

    func setSectionName(name: String){
        sectionName.text = name
    }
    
    func setUpConstraints(){
        sectionName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive
        = true
        sectionName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive
        = true
    }
}
