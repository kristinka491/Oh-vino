//
//  TypesOfWine.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 14.12.2022.
//

import Foundation
import Moya

enum TypesOfWine {
    case wine(type: TypeOfWineEnum)
}

extension TypesOfWine: TargetType {

    var baseURL: URL {
        guard let url = URL(string: "https://api.sampleapis.com/wines/") else {
            fatalError()
        }
        return url
    }

    var path: String {
        switch self {
        case .wine(let type):
            return type.path
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var method: Moya.Method {
        switch self {
        case .wine:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .wine:
            return .requestPlain
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        return Data()
    }
}

