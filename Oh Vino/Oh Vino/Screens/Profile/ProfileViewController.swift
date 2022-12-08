//
//  ProfileViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 07.12.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var deleteProfileButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    private let realmDataStore = RealmDataStore.shared
    private let localManager = LocalManager()
    private var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpButtons()
        setUpAvatarImage()
        getCurrentUser()
    }

    @IBAction func tappedEditProfileButton(_ sender: UIButton) {
        let controller = viewController(storyboardName: "EditProfileScreen", identifier: "EditProfileScreen", isNavigation: false)
        navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func tappedLogOutButton(_ sender: UIButton) {
        cleanSavedData()
        moveToLoginScreen()
    }

    @IBAction func tappedDeleteAccountButton(_ sender: UIButton) {

    }

    private func setUpViews() {
        profileView.layer.cornerRadius = 50
    }

    private func setUpButtons() {
        editProfileButton.layer.cornerRadius = 10
        logOutButton.layer.cornerRadius = 10
        deleteProfileButton.layer.cornerRadius = 10
    }

    private func setUpAvatarImage() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
    }

    private func getCurrentUser() {
        if let currentUserLogin = UserDefaults.standard.string(forKey: UserDefaultsKeys.currentUserLogin) {
            user = realmDataStore.getUser(with: currentUserLogin)
            setUpViewData()
        }
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
