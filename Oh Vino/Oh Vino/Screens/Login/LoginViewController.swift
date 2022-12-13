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
        if let userName = usernameTextField.text,
           let password = passwordTextField.text {
            let result = realmDataStore.loginUser(username: userName, password: password)
            switch result {
            case .success(_):
                saveToUserDefaults(username: userName)
                moveToHomeScreen()
            case .failure(let error):
                showAlert(alertText: error.title, alertMessage: error.message, completion: nil)
            }
        } else {
            showAlert(alertText: "Error", alertMessage: "Please enter username and password", completion: nil)
        }
    }

    @IBAction func tappedHidePasswordButton(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        setPasswordToggleImage(sender)
    }

    private func saveToUserDefaults(username: String) {
        userDefaults.set(isButtonActive, forKey: UserDefaultsKeys.isUserRemembered)
        userDefaults.set(true, forKey: UserDefaultsKeys.isUserLoggedIn)
        userDefaults.set(username, forKey: UserDefaultsKeys.currentUserLogin)
    }

    private func moveToHomeScreen() {
        let controller = viewController(storyboardName: "TabBarScreen", identifier: "TabBarScreen", isNavigation: false)
        navigationController?.pushViewController(controller, animated: true)
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
