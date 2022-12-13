//
//  DataError.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 09.12.2022.
//

import UIKit

enum DataError: Error {
    case userIsNotRegistered
    case wrongUsernameOrPassword
    case theSamePassword
    case userIsRegistered

    var title: String {
        switch self {
        case .userIsNotRegistered:
            return "Something went wrong"
        case .wrongUsernameOrPassword:
            return "Please try again"
        case .theSamePassword:
            return "Please try again"
        case .userIsRegistered:
            return "Something went wrong"
        }
    }

    var message: String {
        switch self {
        case .userIsNotRegistered:
            return "This user is not registered"
        case .wrongUsernameOrPassword:
            return "Wrong username or password"
        case .theSamePassword:
            return "The password should not conform the old one"
        case .userIsRegistered:
            return "This user is already registered"
        }
    }
}
