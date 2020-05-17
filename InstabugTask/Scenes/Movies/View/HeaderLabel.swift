//
//  UILabel+Extension.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

class HeaderLabel: UILabel{
    // MARK: - Original Content size
    private var originalContentSize: CGSize{
        return super.intrinsicContentSize
    }
    // MARK: - Adding padding to label
    override var intrinsicContentSize: CGSize{
        return CGSize(width: originalContentSize.width + 32, height: originalContentSize.height + 16)
    }
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setting label style
    private func setUpLabel() {
        self.layer.cornerRadius = (originalContentSize.height+16)
        self.layer.masksToBounds = true
        self.backgroundColor = Constants.Colors.primaryBlue
        self.textColor = .white
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}
