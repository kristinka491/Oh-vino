//
//  ImagePickerManager.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 06.12.2022.
//

import UIKit

class ImagePickerManager: NSObject {
    static let shared = ImagePickerManager()

    private override init() {}

    fileprivate var currentVC: UIViewController?
    var imagePicked: ((UIImage) -> Void)?
    var sourceType: UIImagePickerController.SourceType?
    var completion: ((_ image: UIImage, _ sourceType: UIImagePickerController.SourceType) -> Void)?

    func showActionSheet(vc: UIViewController,
                         completion: @escaping (_ image: UIImage,
                                                _ sourceType: UIImagePickerController.SourceType) -> Void) {
        currentVC = vc
        self.completion = completion

        let actionSheet = UIAlertController(title: "Upload Photo",
                                            message: nil,
                                            preferredStyle: .actionSheet)

        let photoAction = UIAlertAction(title: "Take Photo", style: .default) { [weak self] action -> Void in
            self?.sourceType = .camera
            self?.getImage(fromSourceType: .camera)
        }
        actionSheet.addAction(photoAction)

        let galleryAction = UIAlertAction(title: "Choose from Gallery", style: .default) { [weak self] action -> Void in
            self?.sourceType = .photoLibrary
            self?.getImage(fromSourceType: .photoLibrary)
        }
        actionSheet.addAction(galleryAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cancelAction)

        currentVC?.present(actionSheet, animated: true)
    }

    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            currentVC?.present(imagePickerController, animated: true)
        }
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
           let sourceType = self.sourceType {
            imagePicked?(image)
            completion?(image, sourceType)
            picker.dismiss(animated: true, completion: nil)
        } else {
            print("Something went wrong")
        }
    }
}
