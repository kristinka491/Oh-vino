//
//  TypeOfWineEnum.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 14.12.2022.
//

import UIKit

enum TypeOfWineEnum: String, CaseIterable {
    case reds = "Reds"
    case whites = "Whites"
    case sparkling = "Sparkling"
    case rose = "Rose"
    case dessert = "Dessert"
    case port = "Port"

    var path: String {
        switch self {
        case .reds:
            return "reds"
        case .whites:
            return "whites"
        case .sparkling:
            return "sparkling"
        case .rose:
            return "rose"
        case .dessert:
            return "dessert"
        case .port:
            return "port"
        }
    }
}
