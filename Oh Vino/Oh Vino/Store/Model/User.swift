//
//  User.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 06.12.2022.
//

import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var username = ""
    @Persisted var name = ""
    @Persisted var password = ""
    @Persisted var avatarImageURL: String?

    @Persisted var favorites: List<UserFavorites>
}
