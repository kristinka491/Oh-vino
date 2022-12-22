//
//  DescriptionViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 22.12.2022.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!

    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpButton()
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction private func tappedNextButton(_ sender: UIButton) {
        let controller = viewController(storyboardName: "GetStartedScreen", identifier: "GetStartedScreen")
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction private func tappedSkipButton(_ sender: UIButton) {
        view.window?.rootViewController = viewController(storyboardName: "LoginScreen", identifier: "LoginScreen", isNavigation: true)
        view.window?.makeKeyAndVisible()
        userDefaults.set(true, forKey: UserDefaultsKeys.isUserOnboarded)
    }

    private func setUpView() {
        descriptionView.layer.cornerRadius = 50
    }

    private func setUpButton() {
        nextButton.layer.cornerRadius = 10
        skipButton.layer.cornerRadius = 10
        skipButton.layer.borderColor = .customColor
        skipButton.layer.borderWidth = 1
    }

}
