//
//  GetStartedViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 22.12.2022.
//

import UIKit

class GetStartedViewController: UIViewController {

    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var getStartedView: UIView!

    private let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButton()
        setUpView()
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction private func tappedGetStartedButton(_ sender: UIButton) {
        view.window?.rootViewController = viewController(storyboardName: "LoginScreen", identifier: "LoginScreen", isNavigation: true)
        view.window?.makeKeyAndVisible()
        userDefaults.set(true, forKey: UserDefaultsKeys.isUserOnboarded)
    }

    private func setUpButton() {
        getStartedButton.layer.cornerRadius = 10
    }

    private func setUpView() {
        getStartedView.layer.cornerRadius = 50
    }
}
