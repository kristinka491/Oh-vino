//
//  StatusModel.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 14.12.2022.
//

import Foundation


struct StatusModel: Codable {
    var status: String?

    private enum CodingKeys: String, CodingKey {
        case status
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(String.self, forKey: .status)
    }
}
