//
//  Padding.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/19/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit
// MARK: - paddings
struct Paddings {
    // default small padding used accross the app
    static let smallPadding = CGFloat(integerLiteral: 6)
    // default padding used accross the app, used to adjust movie cell padding
    static let defaultPadding = CGFloat(integerLiteral: 16)
    // default padding of double size
    static let doublePadding = CGFloat(integerLiteral: 32)
    // default leading padding for text view, this is used to compensate for auto spacing added by text view
    static let textViewLeadingPadding = CGFloat(integerLiteral: 5)
    // default top padding for text view, this is used to compensate for auto spacing added by text view
    static let textViewTopPadding = CGFloat(integerLiteral: 2)
}
