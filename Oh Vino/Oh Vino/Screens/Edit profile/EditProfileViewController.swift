//
//  EditProfileViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 08.12.2022.
//

import UIKit

class EditProfileViewController: SetUpKeyboardViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var saveChangesButton: UIButton!

    private let realmDataStore = RealmDataStore.shared
    private let localManager = LocalManager()
    private let imagePickerManager = ImagePickerManager.shared
    private var isImageSet = false
    private var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewData()
        setUpGestureRecognizer()
        setUpAvatarImage()
    }

    @IBAction func tappedSaveChangesButton(_ sender: UIButton) {
        changeProfile()
        navigationController?.popViewController(animated: true)
    }

    private func changeProfile() {
        if let name = nameTextField.text {
            let imageName = UUID().uuidString
            let oldavatarImageName = realmDataStore.updateProfile(name: name,
                                                                  avatarImageURL: isImageSet ? imageName : nil)
            if isImageSet {
                localManager.deleteImage(imageName: oldavatarImageName)
                localManager.saveImage(image: avatarImageView.image,
                                       imageName: imageName)
            }
        }
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

    private var isChangedData: Bool {
        if let user = user {
            return user.name != nameTextField.text
            }
        return true
    }

    func setUp(with model: User?) {
        user = model
    }

    private func setUpButtonActivity() {
        let isEnable = !nameTextField.text.isEmptyOrNil && isChangedData
        let customColor = UIColor(rgb: 0x9C1E68)
        saveChangesButton.isUserInteractionEnabled = isEnable
        saveChangesButton.setTitleColor(customColor, for: .normal)
        saveChangesButton.setTitleColor(.gray, for: .disabled)
    }

    private func setUpViewData() {
        nameTextField.text = user?.name ?? ""
        usernameLabel.text = user?.username ?? ""
        avatarImageView.image = localManager.getSavedImage(imageName: user?.avatarImageURL) ?? UIImage(named: "avatar")
    }

    private func setUpAvatarImage() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
        avatarImageView.clipsToBounds = true
    }
}

// MARK: -
// MARK: - UITextFieldDelegate

extension EditProfileViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        setUpButtonActivity()
        textField.textColor = .black
    }
}

