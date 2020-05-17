//
//  AddMovieViewController.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import UIKit

class AddMovieViewController:UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var addMovieButton: UIButton!
    // MARK: - Variables
    private var imagePicker = UIImagePickerController()
    private var presenter: AddMoviePresenter!
    private var moviePoster = UIImage(named: "placeholder")
    private let textDelegate = TextFieldDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddMoviePresenter(delegate: self)
        setUpView()
    }
    // MARK: - Set Up views
    func setUpView(){
        titleTextField.delegate = textDelegate
        overviewTextView.delegate = textDelegate
        setUpAddMovieButton()
        setUpImageView()
    }
    // MARK: - Add Movie button stylin
    func setUpAddMovieButton(){
        addMovieButton.layer.cornerRadius = 5
        addMovieButton.backgroundColor = .systemTeal
        addMovieButton.setTitleColor(.white, for: .normal)
    }
    //MARK: - Image View styling
    func setUpImageView(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        posterImageView.isUserInteractionEnabled = true
        posterImageView.addGestureRecognizer(tapGestureRecognizer)
        posterImageView.layer.cornerRadius = 15
    }
    // MARK: - Add movie button pressed
    @IBAction func addMoviePressed(_ sender: Any) {
        presenter.addNewMovie(title: titleTextField.text!, overview: overviewTextView.text!, date: datePicker.date, image: moviePoster!)
    }
    // MARK: - Image view is tapped, select image from gallery
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //show image picker controller
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            posterImageView.image = image
            posterImageView.contentMode = .scaleAspectFill
            self.moviePoster = image
        }
        self.dismiss(animated: true, completion: nil)
    }

}

extension AddMovieViewController: AddMovieDelegate{
    func displayMessage(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
}
