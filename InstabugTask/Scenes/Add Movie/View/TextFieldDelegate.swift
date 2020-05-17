//
//  TextFieldDelegate.swift
//  InstabugTask
//
//  Created by Abdalla Elshikh on 5/17/20.
//  Copyright © 2020 Abdalla Elshikh. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UISearchTextFieldDelegate, UITextViewDelegate{
    // MARK: - When return pressed hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //if return is pressed resign first responder to hide keyboard
        textField.resignFirstResponder()
        return true
    }
    // MARK: - When text field pressed clear text
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //if text edit is pressed clear text
        textField.text = ""
        return true
    }
    // MARK: - When text view pressed clear text
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        return true
    }
    // MARK: - When return is pressed dismiss keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
