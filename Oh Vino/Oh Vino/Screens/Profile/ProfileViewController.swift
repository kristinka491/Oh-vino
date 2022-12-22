//
//  ProfileViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 07.12.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    private let realmDataStore = RealmDataStore.shared
    private let localManager = LocalManager()
    private var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAvatarImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        view.layoutIfNeeded()
        getCurrentUser()
    }

    @IBAction private func tappedEditProfileButton(_ sender: UIButton) {
        if let controller = viewController(storyboardName: "EditProfileScreen", identifier: "EditProfileScreen", isNavigation: false) as? EditProfileViewController {
            controller.setUp(with: user)
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    @IBAction private func tappedLogOutButton(_ sender: UIButton) {
        cleanSavedData()
        moveToLoginScreen()
    }

    @IBAction private func tappedDeleteAccountButton(_ sender: UIButton) {
        if let login = user?.username {
            realmDataStore.deleteUser(with: login)
        }
        moveToLoginScreen()
    }

    @IBAction private func tappedChangePasswordButton(_ sender: UIButton) {
        let controller = viewController(storyboardName: "ChangePasswordScreen", identifier: "ChangePasswordScreen", isNavigation: false)
        navigationController?.pushViewController(controller, animated: true)
    }

    private func setUpAvatarImage() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
    }

    private func getCurrentUser() {
        user = realmDataStore.getCurrentUser()
        setUpViewData()
    }

    private func setUpViewData() {
        nameLabel.text = user?.name ?? ""
        usernameLabel.text = user?.username ?? ""
        avatarImageView.image = localManager.getSavedImage(imageName: user?.avatarImageURL) ?? UIImage(named: "avatar")
    }

    private func cleanSavedData() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentUserLogin)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.isUserLoggedIn)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.isUserRemembered)
    }

    private func moveToLoginScreen() {
        view.window?.rootViewController = viewController(storyboardName: "LoginScreen", identifier: "LoginScreen", isNavigation: true)
        view.window?.makeKeyAndVisible()
    }
}
