//
//  AlertViewController+Extension.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 06.12.2022.
//

import UIKit

extension UIViewController {

    func showAlert(alertText: String, alertMessage: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in completion?() }))
        present(alert, animated: true, completion: nil)
    }
}
