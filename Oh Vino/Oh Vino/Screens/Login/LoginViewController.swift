//
//  ViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 01.12.2022.
//

import UIKit
import AuthenticationServices

class LoginViewController: SetUpKeyboardViewController {

    @IBOutlet weak var formsView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var hidePasswordButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButton: UIButton!

    private let realmDataStore = RealmDataStore.shared
    private let userDefaults = UserDefaults.standard
    private var isButtonActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpformsView()
        setUpSignInButton()
    }

    @IBAction func tappedGetOneButton(_ sender: UIButton) {
        let controller = viewController(storyboardName: "RegistrationScreen", identifier: "RegistrationScreen", isNavigation: false)
        navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func tappedSignInButton(_ sender: UIButton) {
        if !usernameTextField.text.isEmptyOrNil && !passwordTextField.text.isEmptyOrNil {
            if realmDataStore.getUser(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "") != nil {
                userDefaults.set(isButtonActive, forKey: UserDefaultsKeys.isUserRemembered)
                userDefaults.set(true, forKey: UserDefaultsKeys.isUserLoggedIn)
                userDefaults.set(usernameTextField.text, forKey: UserDefaultsKeys.currentUserLogin)
                let controller = viewController(storyboardName: "HomeScreen", identifier: "HomeScreen", isNavigation: false)
                navigationController?.pushViewController(controller, animated: true)
            } else {
                showAlert(alertText: "Please try again", alertMessage: "Wrong username or password", completion: nil)
            }
        } else {
            showAlert(alertText: "Error", alertMessage: "Please enter username and password", completion: nil)
        }
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

    @IBAction private func tappedRememberMeButton(_ sender: UIButton) {
        if isButtonActive {
            rememberMeButton.setImage(UIImage(named: "unchecked"), for: .normal)
        } else {
            rememberMeButton.setImage(UIImage(named: "checked"), for: .normal)
        }
        isButtonActive = !isButtonActive
    }

    private func setUpformsView() {
        formsView.layer.cornerRadius = 50
    }

    private func setUpSignInButton() {
        signInButton.layer.cornerRadius = 10
    }
}
