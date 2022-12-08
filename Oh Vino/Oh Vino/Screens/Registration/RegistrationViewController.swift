//
//  RegistrationViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 05.12.2022.
//

import UIKit

class RegistrationViewController: SetUpKeyboardViewController {

    @IBOutlet weak var formsView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    private let imagePickerManager = ImagePickerManager.shared
    private let realmDataStore = RealmDataStore.shared
    private let localManager = LocalManager()
    private var isImageSet = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFormsView()
        setUpAvatarImage()
        setUpCreateAccountButton()
        setUpGestureRecognizer()
        navigationController?.navigationBar.isHidden = true
        currentTextField = passwordTextField
    }

    @IBAction func tappedCreateAccountButton(_ sender: UIButton) {
        if !nameTextField.text.isEmptyOrNil && !usernameTextField.text.isEmptyOrNil && !passwordTextField.text.isEmptyOrNil {
            registerUser()
            showAlert(alertText: "Thank you!", alertMessage: "Account was created.") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        } else {
            showAlert(alertText: "Error", alertMessage: "Please fill in all the forms", completion: nil)
        }
    }

    @IBAction func tappedSignInButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func tappedHidePasswordButton(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        setPasswordToggleImage(sender)
    }

    private func setPasswordToggleImage(_ button: UIButton) {
        if passwordTextField.isSecureTextEntry{
            button.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }

    private func setUpFormsView() {
        formsView.layer.cornerRadius = 50
    }

    private func setUpAvatarImage() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
    }

    private func setUpCreateAccountButton() {
        createAccountButton.layer.cornerRadius = 10
    }

    private func setUpGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func didTapImageView(_ sender: UITapGestureRecognizer) {
        imagePickerManager.showActionSheet(vc: self) { [weak self] image, _ in
            self?.avatarImageView.image = image
            self?.isImageSet = true
        }
    }

    private func registerUser() {
        var avatarImageName: String?
        if isImageSet {
            avatarImageName = localManager.saveImage(image: avatarImageView.image)
        }
        let isUserSaved = realmDataStore.addUser(name: nameTextField.text ?? "",
                                                 username: usernameTextField.text ?? "",
                                                 password: passwordTextField.text ?? "",
                                                 avatarImageURL: avatarImageName)
        if !isUserSaved {
            showAlert(alertText: "Something went wrong", alertMessage: "This user is already signed up") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

// MARK: -
// MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        let isUserRegistered = realmDataStore.isUserRegistered(with: usernameTextField.text ?? "")
        if textField == usernameTextField && isUserRegistered {
            showAlert(alertText: "Sorry", alertMessage: "Unfortunately, this username is busy", completion: nil)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string == " " ? false : true
    }
}
