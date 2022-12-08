//
//  LocalManager.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 06.12.2022.
//

import UIKit

class LocalManager {

    private var directory: NSURL? {
        return try? FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false) as NSURL
    }

    func saveImage(image: UIImage?) -> String? {
        guard let directory = directory,
              let data = image?.jpegData(compressionQuality: 1) else { return nil }
        do {
            let imageName = UUID().uuidString
            if let uploadPath = directory.appendingPathComponent("\(imageName)") {
                try data.write(to: uploadPath)
                return imageName
            }
            return nil
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func getSavedImage(imageName: String?) -> UIImage? {
        guard let imageName = imageName,
              let url = directory?.appendingPathComponent("\(imageName)") else {
            return nil
        }

        do {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
}
