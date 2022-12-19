//
//  HomeViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 06.12.2022.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var typeOfWineCollectionView: UICollectionView!
    @IBOutlet weak var wineCollectionView: UICollectionView!

    private let realmDataStore = RealmDataStore.shared
    private let networkManager = NetworkManager.shared

    private let numberOfCellsOfTypeOfWineInRow = 4
    private let numberOfCellsOfWineInRow = 2
    private let spaceBetweenCells = 0
    private let spaceBetweenWinesCells = 10

    private let typesOfWine = TypeOfWineEnum.allCases
    private var user: User?
    private var wines = [WineModel]()
    private var filteredData = [WineModel]()
    private var selectedTypeOfWine: TypeOfWineEnum = .reds
    private var isFirstLoad = true


    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUser()
        setUpCollectionView()
        setUpSearchBar()

        loadData(typeOfWine: selectedTypeOfWine)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        refreshFavorites()
        navigationController?.navigationBar.isHidden = true
        view.layoutIfNeeded()
    }

    private func refreshFavorites() {
        updateModel(model: filteredData)
        updateModel(model: wines)
        wineCollectionView.reloadData()
    }

    private func loadData(typeOfWine: TypeOfWineEnum) {
        let alertVC = showLoader()
        networkManager.wines(typeOfWine: typeOfWine) { [weak self] model, _ in
            self?.dismissLoader(alert: alertVC)
            self?.updateModel(model: model)
            self?.wines = model ?? []
            self?.filteredData = model ?? []

            self?.wineCollectionView.setContentOffset(.zero, animated: true)
            self?.wineCollectionView.reloadData()
        }
    }

    private func updateModel(model: [WineModel]?) {
        model?.forEach { [weak self] wineModel in
            wineModel.isFavorite = self?.realmDataStore.isWineFavorite(wine: wineModel.wine ?? "") ?? false
        }
    }

    private func getCurrentUser() {
        user = realmDataStore.getCurrentUser()
        setUpLabel()
    }

    private func setUpLabel() {
        helloLabel.text = "Hello, \(user?.name ?? "")"
    }

    private func setUpCollectionView() {
        let wineLayout = UICollectionViewFlowLayout()
        let typesOfWineLayout = UICollectionViewFlowLayout()
        typesOfWineLayout.scrollDirection = .horizontal

        typeOfWineCollectionView.delegate = self
        wineCollectionView.delegate = self
        typeOfWineCollectionView.dataSource = self
        wineCollectionView.dataSource = self

        typeOfWineCollectionView.collectionViewLayout = typesOfWineLayout
        wineCollectionView.collectionViewLayout = wineLayout

        typeOfWineCollectionView.register(UINib(nibName: "TypeOfWinesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "typeOfWineCell")
        wineCollectionView.register(UINib(nibName: "WineCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "wineCell")
    }

    private func setUpSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
    }
}

// MARK: -
// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case typeOfWineCollectionView:
            return typesOfWine.count
        case wineCollectionView:
            return filteredData.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case typeOfWineCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeOfWineCell", for: indexPath) as? TypeOfWinesCollectionViewCell {
                cell.setUpCell(typesOfWine[indexPath.row])
                if indexPath.row == 0,
                   isFirstLoad {
                    isFirstLoad = false
                    typeOfWineCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
                }
                return cell
            }
            return UICollectionViewCell()
        case wineCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wineCell", for: indexPath) as? WineCollectionViewCell {
                cell.setUpCell(filteredData[indexPath.row], addDelegate: self, deleteDelegate: self)
                return cell
            }
            return UICollectionViewCell()
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case typeOfWineCollectionView:
            let cellWidth = (Int(UIScreen.main.bounds.width) - spaceBetweenCells * (numberOfCellsOfTypeOfWineInRow + 1)) / numberOfCellsOfTypeOfWineInRow
            return CGSize(width: cellWidth, height: 45)
        case wineCollectionView:
            let cellWidth = (Int(UIScreen.main.bounds.width) - spaceBetweenWinesCells * (numberOfCellsOfWineInRow + 1)) / numberOfCellsOfWineInRow
            return CGSize(width: cellWidth, height: 270)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case typeOfWineCollectionView:
            let newSelectedType = typesOfWine[indexPath.row]
            if selectedTypeOfWine != newSelectedType {
                selectedTypeOfWine = newSelectedType
                searchBar.text?.removeAll()
                loadData(typeOfWine: selectedTypeOfWine)
            }
        case wineCollectionView:
            break
        default:
            break
        }
    }

    private func updateArray(array: [WineModel], currentWine: String, isFavorite: Bool = true) {
        array.forEach { wineModel in
            if wineModel.wine == currentWine {
                wineModel.isFavorite = isFavorite
            }
        }
    }
}

// MARK: -
// MARK: - UISearchBarDelegate


extension HomeViewController: UISearchBarDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? wines : wines.filter( { ($0.wine ?? "").localizedCaseInsensitiveContains(searchText) })
        wineCollectionView.reloadData()
    }
}

// MARK: -
// MARK: - AddToFavoritesDelegate

extension HomeViewController: AddToFavoritesDelegate {

    func addToFavorites(model: WineModel?) -> Bool {
        if let model = model {
            addUserFavorites(model: model)
            updateArray(array: wines, currentWine: model.wine ?? "")
            updateArray(array: filteredData, currentWine: model.wine ?? "")
            return true
        }
        return false
    }

    private func addUserFavorites(model: WineModel) {
        let isUserFavoriteSaved = realmDataStore.addUserFavorites(model: model)
        if !isUserFavoriteSaved {
            moveToLoginScreen()
        } else {
            print("wine saved to favorites")
        }
    }

    private func moveToLoginScreen() {
        showAlert(alertText: "Something went wrong", alertMessage: "This user is not signed in") { [weak self] in
            self?.view.window?.rootViewController = self?.viewController(storyboardName: "LoginScreen", identifier: "LoginScreen", isNavigation: true)
            self?.view.window?.makeKeyAndVisible()
        }
    }
}

// MARK: -
// MARK: - DeleteFromFavoritesDelegate

extension HomeViewController: DeleteFromFavoritesDelegate {

    func deleteFromFavorites(wine: String?) {
        realmDataStore.deleteFromFavorites(with: wine ?? "")
        updateArray(array: wines, currentWine: wine ?? "", isFavorite: false)
        updateArray(array: filteredData, currentWine: wine ?? "", isFavorite: false)
    }

}
