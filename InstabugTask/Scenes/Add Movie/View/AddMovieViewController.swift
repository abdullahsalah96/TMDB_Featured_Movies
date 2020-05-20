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
    private var moviePoster = Images.placeholderImage
    private var imagePicker = UIImagePickerController()
    private var presenter: AddMoviePresenter!
    private var movieDate: Date!
    private let textDelegate = TextFieldDelegate()
    // MARK: - View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddMoviePresenter(delegate: self)
        setUpView()
    }
    // MARK: - Set Up views
    func setUpView(){
        view.backgroundColor = Colors.primaryDark
        setUpDatePicker()
        setUpText()
        setUpAddMovieButton()
        setUpImageView()
    }
    // MARK: - Initialize date to current date picker date
    func setUpDatePicker(){
        datePicker.setValue(Colors.primaryBlue, forKeyPath: "textColor")
        // initializing time zone to Egypt
        let seconds = 2*60*60 //GMT+2
        datePicker.timeZone = TimeZone(secondsFromGMT: seconds)
        // whenever date picker value is changed update movie date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(picker:)), for: .valueChanged)
        // init movie date to current selected date picker date
        movieDate = datePicker.date
    }
    // MARK: - Setup Text Views and fields
    private func setUpText() {
        setUpTextDelegate()
        setUpTitleTextField()
        setUpOverviewTextView()
        let padding = Paddings.smallPadding
        overviewTextView.textContainerInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    // MARK: - Setup title text field
    private func setUpTitleTextField() {
        titleTextField.backgroundColor = Colors.primaryTextFields
        titleTextField.text = ""
        titleTextField.textColor = Colors.primaryLight
        titleTextField.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
        titleTextField.layer.masksToBounds = true
    }
    // MARK: - Setup overview text view
    fileprivate func setUpOverviewTextView() {
        overviewTextView.backgroundColor = Colors.primaryTextFields
        overviewTextView.text = ""
        overviewTextView.textColor = Colors.primaryLight
        overviewTextView.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
    }
    // MARK: - Set up text delegates
    func setUpTextDelegate(){
        titleTextField.delegate = textDelegate
        overviewTextView.delegate = textDelegate
    }
    // MARK: - Add Movie button stylin
    func setUpAddMovieButton(){
        addMovieButton.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
        addMovieButton.backgroundColor = Colors.primaryBlue
        addMovieButton.setTitleColor(.white, for: .normal)
    }
    //MARK: - Image View styling
    func setUpImageView(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        posterImageView.isUserInteractionEnabled = true
        posterImageView.addGestureRecognizer(tapGestureRecognizer)
        posterImageView.layer.cornerRadius = Constants.BorderRadii.defaultBorderRadius
    }
    // MARK: - Update movie Poster
    func updateMoviePoster(image: UIImage){
        self.moviePoster = image
    }
    // MARK: - Actions
    // MARK: - Add movie button pressed
    @IBAction func addMoviePressed(_ sender: Any) {
        presenter.addNewMovie(title: titleTextField.text, overview: overviewTextView.text, date: movieDate, image: moviePoster)
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
