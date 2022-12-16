//
//  TypesOfWineModel.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 14.12.2022.
//

import UIKit

class WineModel: Codable {
    var winery: String?
    var wine: String?
    var image: String?
    var isFavorite = false

    private enum CodingKeys: String, CodingKey {
        case winery, wine, image
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        winery = try container.decodeIfPresent(String.self, forKey: .winery)
        wine = try container.decodeIfPresent(String.self, forKey: .wine)
        image = try container.decodeIfPresent(String.self, forKey: .image)
    }
}
