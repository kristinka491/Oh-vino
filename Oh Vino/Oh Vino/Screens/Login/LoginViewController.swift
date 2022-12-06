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
    @IBOutlet weak var appleContainerView: UIView!
    @IBOutlet weak var hidePasswordButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButton: UIButton!

    private let signInWithAppleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
    private var isButtonActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpformsView()
        setUpSignInButton()
        setUpSignInWithAplleButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInWithAppleButton.frame = CGRect(x: 0, y: 0, width: appleContainerView.frame.width, height: 50)
    }

    @IBAction func tappedGetOneButton(_ sender: UIButton) {
        let controller = viewController(storyboardName: "RegistrationScreen", identifier: "RegistrationScreen", isNavigation: false)
        navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func tappedSignInButton(_ sender: UIButton) {

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

    private func setUpSignInWithAplleButton() {
        appleContainerView.addSubview(signInWithAppleButton)
        signInWithAppleButton.addTarget(self, action: #selector(didTapSignInWithApple), for: .touchUpInside)
    }

    @objc private func didTapSignInWithApple() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate{

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error")
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let username = appleIDCredential.user
            let firstName = appleIDCredential.fullName?.givenName
            let lastName = appleIDCredential.fullName?.familyName
        default:
            break
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
