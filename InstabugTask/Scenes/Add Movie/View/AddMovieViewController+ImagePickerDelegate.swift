//
//  AddMovieViewController+ImagePickerDelegate.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/20/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Image Picker Controller Delegate
extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //show image picker controller
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            posterImageView.image = image
            posterImageView.contentMode = .scaleAspectFill
            // update movie poster
            self.updateMoviePoster(image: image)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
