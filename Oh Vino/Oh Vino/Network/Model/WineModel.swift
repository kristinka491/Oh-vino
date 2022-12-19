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
    var wineImageURL: String?
    var isFavorite = false

    init(model: UserFavorites) {
        self.wine = model.wine
        self.wineImageURL = model.wineImageURL
        self.winery = model.winery
        self.isFavorite = true
    }

    private enum CodingKeys: String, CodingKey {
        case winery, wine, wineImageURL = "image"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        winery = try container.decodeIfPresent(String.self, forKey: .winery)
        wine = try container.decodeIfPresent(String.self, forKey: .wine)
        wineImageURL = try container.decodeIfPresent(String.self, forKey: .wineImageURL)
    }
}
