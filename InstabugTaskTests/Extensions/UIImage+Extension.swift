//
//  UIImageView+Extension.swift
//  InstabugTaskTests
//
//  Created by Abdalla Elshikh on 5/18/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    // function to compare between two images, used for test when comparing invalid poster path to placeholder image
    func isEqualToImage(image: UIImage) -> Bool {
        // compares two images and returns true if they contain same data
        let data1: Data = self.pngData()!
        let data2: Data = image.pngData()!
        return data1 == data2
    }

}
