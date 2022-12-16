//
//  ChangePasswordViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 13.12.2022.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!

    private let realmDataStore = RealmDataStore.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func tappedSaveChangesButton(_ sender: UIButton) {
        setNewPassword()
    }

    @IBAction func tappedHideNewPasswordButton(_ sender: UIButton) {
        newPasswordTextField.isSecureTextEntry = !newPasswordTextField.isSecureTextEntry
        setToggleImage(newPasswordTextField.isSecureTextEntry, sender)
    }

    @IBAction func tappedConfirmPasswordButton(_ sender: UIButton) {
        confirmNewPasswordTextField.isSecureTextEntry = !confirmNewPasswordTextField.isSecureTextEntry
        setToggleImage(confirmNewPasswordTextField.isSecureTextEntry, sender)
    }

    private func setToggleImage(_ isSecureTextEntry: Bool, _ button: UIButton) {
        if isSecureTextEntry{
            button.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }

    private func setNewPassword() {
        if let newPassword = newPasswordTextField.text,
           let confirmPassword = confirmNewPasswordTextField.text {
            if newPassword == confirmPassword {
                let result = realmDataStore.changePassword(password: newPassword)

                switch result {
                case .success():
                    moveToProfileScreen()
                case .failure(let error):
                    showAlert(alertText: error.title, alertMessage: error.message, completion: nil)
                }
            } else {
                showAlert(alertText: "Something went wrong", alertMessage: "Passwords are not the same", completion: nil)
            }
        }
    }

    private func moveToProfileScreen() {
        let controller = viewController(storyboardName: "ProfileScreen", identifier: "ProfileScreen", isNavigation: false)
        navigationController?.pushViewController(controller, animated: true)
    }

}
