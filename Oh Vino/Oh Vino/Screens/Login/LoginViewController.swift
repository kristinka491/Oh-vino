//
//  ViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 01.12.2022.
//

import UIKit
import AuthenticationServices

class LoginViewController: SetUpKeyboardViewController {

    private let signInWithAppleButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)

    @IBOutlet weak var formsView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var appleContainerView: UIView!
    @IBOutlet weak var hidePasswordButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


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
        }else{
            button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
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

               // Create an account in your system.
            let firstName = appleIDCredential.fullName?.givenName
            let lastName = appleIDCredential.fullName?.familyName
            let email = appleIDCredential.email
            break

//               // For the purpose of this demo app, store the `userIdentifier` in the keychain.
//               self.saveUserInKeychain(userIdentifier)
//
//               // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
//               self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
//
//           case let passwordCredential as ASPasswordCredential:
//
//               // Sign in using an existing iCloud Keychain credential.
//               let username = passwordCredential.user
//               let password = passwordCredential.password
//
//               // For the purpose of this demo app, show the password credential as an alert.
//               DispatchQueue.main.async {
//                   self.showPasswordCredentialAlert(username: username, password: password)
//               }

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
