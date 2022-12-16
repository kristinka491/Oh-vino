//
//  UserFavorites.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 16.12.2022.
//

import UIKit
import RealmSwift

class UserFavorites: Object {
    @Persisted(primaryKey: true) var wine = ""
    @Persisted var winery = ""
    @Persisted var wineImageURL = ""
}
