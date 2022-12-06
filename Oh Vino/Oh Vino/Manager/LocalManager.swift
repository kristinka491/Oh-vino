//
//  LocalManager.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 06.12.2022.
//

import UIKit

class LocalManager {

    func saveImage(image: UIImage?) -> URL? {
        guard let directory = try? FileManager.default.url(for: .documentDirectory,
                                                              in: .userDomainMask,
                                                              appropriateFor: nil,
                                                              create: false) as NSURL,
              let data = image?.jpegData(compressionQuality: 1) else { return nil }
        do {
            if let uploadPath = directory.appendingPathComponent("\(UUID().uuidString)") {
                try data.write(to: uploadPath)
                return uploadPath
            }
            return nil
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func getSavedImage(urlString: String?) -> UIImage? {
        guard let urlString = urlString else {
            return nil
        }
        return UIImage(contentsOfFile: urlString)
    }
}
