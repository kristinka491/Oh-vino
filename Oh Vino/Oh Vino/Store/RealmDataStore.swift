//
//  RealmDataStore.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 06.12.2022.
//

import RealmSwift
import UIKit

class RealmDataStore {

    static let shared = RealmDataStore()

    private let realm = try? Realm()

    func addUser(name: String,
                 username: String,
                 password: String,
                 avatarImageURL: String?) -> Bool {
        if !isUserRegistered(with: username) {
            let user = User()
            user.name = name
            user.username = username
            user.password = password
            user.avatarImageURL = avatarImageURL
            saveObject(user: user)

            return true
        }
        return false
    }

    func getUser(with username: String) -> User? {
        return realm?.object(ofType: User.self,
                                 forPrimaryKey: username)
    }

    func getUser(username: String, password: String) -> User? {
        if let user = getUser(with: username),
           user.password == password {
            return user
        }
        return nil
    }

    func isUserRegistered(with username: String) -> Bool {
        return getUser(with: username) != nil
    }

    private func saveObject(user: User) {
        try? realm?.write {
            realm?.add(user)
        }
        print("Data Was Saved To Realm Database.")
    }
    
}
