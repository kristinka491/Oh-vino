//
//  WelcomeViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 22.12.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!

    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpButton()
    }

    @IBAction private func tappedNextButton(_ sender: UIButton) {
        let controller = viewController(storyboardName: "DescriptionScreen", identifier: "DescriptionScreen")
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction private func tappedSkipButton(_ sender: UIButton) {
        view.window?.rootViewController = viewController(storyboardName: "LoginScreen", identifier: "LoginScreen", isNavigation: true)
        view.window?.makeKeyAndVisible()
        userDefaults.set(true, forKey: UserDefaultsKeys.isUserOnboarded)
    }

    private func setUpView() {
        welcomeView.layer.cornerRadius = 50
    }

    private func setUpButton() {
        nextButton.layer.cornerRadius = 10
        skipButton.layer.cornerRadius = 10
        skipButton.layer.borderColor = .customColor
        skipButton.layer.borderWidth = 1
    }
}
