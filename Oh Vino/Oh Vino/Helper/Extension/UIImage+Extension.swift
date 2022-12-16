//
//  UIImage+Extension.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 15.12.2022.
//

import UIKit

extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }

    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}
