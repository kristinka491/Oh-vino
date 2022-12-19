//
//  WineCollectionViewCell.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 14.12.2022.
//

import UIKit

protocol AddToFavoritesDelegate: AnyObject {
    func addToFavorites(model: WineModel?) -> Bool
}

protocol DeleteFromFavoritesDelegate: AnyObject {
    func deleteFromFavorites(wine: String?)
}

class WineCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var wineView: UIView!
    @IBOutlet weak var backgroundsView: UIView!
    @IBOutlet weak var wineNameLabel: UILabel!
    @IBOutlet weak var wineryNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    private weak var addDelegate: AddToFavoritesDelegate?
    private weak var deleteDelegate: DeleteFromFavoritesDelegate?
    private var wineModel: WineModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    @IBAction func tappedLikeButton(_ sender: UIButton) {
        if wineModel?.isFavorite ?? true {
            deleteDelegate?.deleteFromFavorites(wine: wineModel?.wine)
            wineModel?.isFavorite = false
        } else {
            if addDelegate?.addToFavorites(model: wineModel) ?? false {
                wineModel?.isFavorite = true
            }
        }
        updateButtonImage(with: wineModel?.isFavorite ?? true)
    }

    private func updateButtonImage(with isFavorite: Bool) {
        let buttonImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(buttonImage, for: .normal)
    }

    private func setUpView() {
        wineView.layer.cornerRadius = 20
        backgroundsView.layer.cornerRadius = 20
    }

    func setUpCell(_ model: WineModel, addDelegate: AddToFavoritesDelegate? = nil, deleteDelegate: DeleteFromFavoritesDelegate? = nil) {
        wineModel = model
        self.addDelegate = addDelegate
        self.deleteDelegate = deleteDelegate

        wineNameLabel.text = model.wine
        wineryNameLabel.text = model.winery
        wineImageView.image = UIImage(url: URL(string: model.wineImageURL ?? ""))
        updateButtonImage(with: model.isFavorite)
    }
}
