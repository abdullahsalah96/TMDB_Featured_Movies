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
    private var moviePoster = Constants.Images.placeholderImage
    private var movieDate: Date!
    private let textDelegate = TextFieldDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddMoviePresenter(delegate: self)
        setUpView()
    }
    // MARK: - Set Up views
    func setUpView(){
        view.backgroundColor = Constants.Colors.primaryDark
        setUpDatePicker()
        setUpTextFields()
        setUpAddMovieButton()
        setUpImageView()
    }
    // MARK: - Initialize date to current date picker date
    func setUpDatePicker(){
        datePicker.setValue(Constants.Colors.primaryBlue, forKeyPath: "textColor")
        // initializing time zone to Egypt
        let seconds = 2*60*60 //GMT+2
        datePicker.timeZone = TimeZone(secondsFromGMT: seconds)
        // whenever date picker value is changed update movie date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(picker:)), for: .valueChanged)
        // init movie date to current selected date picker date
        movieDate = datePicker.date
    }
    private func setUpTextFields() {
        setUpTextDelegate()
        titleTextField.backgroundColor = .systemGray
        titleTextField.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
        titleTextField.layer.masksToBounds = true
        overviewTextView.backgroundColor = .systemGray
        overviewTextView.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
        let padding = Constants.Padding.smallPadding
        overviewTextView.textContainerInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    // MARK: - Set up text delegates
    func setUpTextDelegate(){
        titleTextField.delegate = textDelegate
        overviewTextView.delegate = textDelegate
    }
    // MARK: - Add Movie button stylin
    func setUpAddMovieButton(){
        addMovieButton.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
        addMovieButton.backgroundColor = Constants.Colors.primaryBlue
        addMovieButton.setTitleColor(.white, for: .normal)
    }
    //MARK: - Image View styling
    func setUpImageView(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        posterImageView.isUserInteractionEnabled = true
        posterImageView.addGestureRecognizer(tapGestureRecognizer)
        posterImageView.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
    }
    // MARK: - Add movie button pressed
    @IBAction func addMoviePressed(_ sender: Any) {
        presenter.addNewMovie(title: titleTextField.text!, overview: overviewTextView.text!, date: movieDate, image: moviePoster!)
    }
    // MARK: - Date Picker Value Changed
    @objc func datePickerValueChanged(picker: UIDatePicker) {
        movieDate = picker.date
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
