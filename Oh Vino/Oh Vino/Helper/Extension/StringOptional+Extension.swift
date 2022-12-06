//
//  StringOptional+Extension.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 06.12.2022.
//

import UIKit

extension Optional where Wrapped == String {

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}
