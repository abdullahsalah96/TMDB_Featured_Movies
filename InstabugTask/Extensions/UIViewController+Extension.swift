//
//  UIViewController+Extension.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    // MARK: - Show Alert View Controller with error
    func showAlert(title: String, message:String){
        let errorVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(errorVC, animated: true)
    }
}
