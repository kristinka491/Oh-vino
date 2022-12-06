//
//  SetUpKeyboard.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 05.12.2022.
//

import UIKit

class SetUpKeyboardViewController: UIViewController {

    var currentTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
    }

    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardFrame = view.convert(keyboardSize, from: nil)
            if let currentTextField = currentTextField,
               let textFieldFrame = currentTextField.superview?.convert(currentTextField.frame, to: view),
               keyboardFrame.intersects(textFieldFrame) {
                let spaceBetweenKeyboardAndTextField = currentTextField.frame.maxY - keyboardFrame.origin.y + 10
                view.frame.origin.y += spaceBetweenKeyboardAndTextField
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}
