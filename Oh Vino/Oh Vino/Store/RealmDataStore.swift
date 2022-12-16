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
                 avatarImageURL: String?) -> Result<User, DataError> {
        if !isUserRegistered(with: username) {
            let user = User()
            user.name = name
            user.username = username
            user.password = password
            user.avatarImageURL = avatarImageURL
            saveObject(user: user)

            return .success(user)
        }
        return .failure(.userIsRegistered)
    }

    func getUser(with username: String) -> User? {
        return realm?.object(ofType: User.self,
                                 forPrimaryKey: username)
    }

    func loginUser(username: String, password: String) -> Result<User, DataError> {
        if let user = getUser(with: username) {
            return user.password == password ? .success(user) : .failure(.wrongUsernameOrPassword)
        }
        return .failure(.userIsNotRegistered)
    }

    func isUserRegistered(with username: String) -> Bool {
        return getUser(with: username) != nil
    }

    func deleteUser(with login: String) {
        if let user = realm?.object(ofType: User.self,
                                    forPrimaryKey: login) {
            try? realm?.write {
                realm?.delete(user)
            }
        }
    }

    func updateProfile(name: String,
                       avatarImageURL: String?) -> String? {
            let currentUser = getCurrentUser()
            let oldavatarImageName = currentUser?.avatarImageURL

            try? realm?.write {
                currentUser?.name = name
                if let avatarImageURL = avatarImageURL {
                    currentUser?.avatarImageURL = avatarImageURL
            }
        }
        return oldavatarImageName
    }

    func changePassword(password: String) -> Result<Void, DataError> {
        if let user = getCurrentUser() {
            if user.password != password {
                try? realm?.write {
                    user.password = password
                }
                return .success(())
            }
        }
        return .failure(.theSamePassword)
    }

    func addUserFavorites(model: WineModel) -> Bool {
        if let currentUserLogin = UserDefaults.standard.string(forKey: UserDefaultsKeys.currentUserLogin),
            let currentUser = realm?.object(ofType: User.self,
                                          forPrimaryKey: currentUserLogin) {
            let userFavorites = UserFavorites()

            try? realm?.write {
                userFavorites.wine = model.wine ?? ""
                userFavorites.winery = model.winery ?? ""
                userFavorites.wineImageURL = model.image ?? ""

                currentUser.favorites.append(userFavorites)
            }
            return true
        }
        return false
    }

    func deleteFromFavorites(with wine: String) {
        if let userFavorite = realm?.object(ofType: UserFavorites.self,
                                            forPrimaryKey: wine) {

            try? realm?.write {
                realm?.delete(userFavorite)
            }
        }
    }

    func isWineFavorite(wine: String) -> Bool {
        return realm?.object(ofType: UserFavorites.self,
                             forPrimaryKey: wine) != nil
    }

    private func getCurrentUser() -> User? {
        if let currentUserLogin = UserDefaults.standard.string(forKey: UserDefaultsKeys.currentUserLogin) {
            return getUser(with: currentUserLogin)
        }
        return nil
    }

    private func saveObject(user: User) {
        try? realm?.write {
            realm?.add(user)
        }
        print("Data Was Saved To Realm Database.")
    }
    
}
