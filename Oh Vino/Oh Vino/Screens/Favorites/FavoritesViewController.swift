//
//  FavoritesViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 07.12.2022.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyCollectionViewLabel: UILabel!

    private let realmDataStore = RealmDataStore.shared

    private let numberOfCellsInRow = 2
    private let spaceBetweenCells = 10

    private var user: User?
    private var userNotification: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        getCurrentUser()
        setUpCollectionViewIsHidden()
    }

    deinit {
        userNotification?.invalidate()
    }

    private var favoriteWines: [UserFavorites] {
        return user?.favorites.toArray() ?? []
    }

    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UINib(nibName: "WineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "wineCell")
    }

    private func getCurrentUser() {
        user = realmDataStore.getCurrentUser()
        userNotification = user?.favorites.observe { [weak self] _ in
            self?.setUpCollectionViewIsHidden()
            self?.collectionView.reloadData()
        }
    }

    private func setUpCollectionViewIsHidden() {
        collectionView.isHidden = favoriteWines.isEmpty
    }
}

// MARK: -
// MARK: - UICollectionViewDelegate

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteWines.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wineCell", for: indexPath) as? WineCollectionViewCell {
            cell.setUpCell(WineModel(model: favoriteWines[indexPath.row]), deleteDelegate: self)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (Int(UIScreen.main.bounds.width) - spaceBetweenCells * (numberOfCellsInRow + 1)) / numberOfCellsInRow
        return CGSize(width: cellWidth, height: 270)
    }
}

// MARK: -
// MARK: - AddToFavoritesDelegate

extension FavoritesViewController: DeleteFromFavoritesDelegate {

    func deleteFromFavorites(wine: String?) {
        realmDataStore.deleteFromFavorites(with: wine ?? "")
    }
}
