//
//  TypeOfVinesCollectionViewCell.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 14.12.2022.
//

import UIKit

class TypeOfWinesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var typeOfWineLabel: UILabel!
    @IBOutlet weak var wineView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    override var isSelected: Bool {
        didSet {
            wineView.backgroundColor = isSelected ? UIColor.systemGray6 : UIColor.white
        }
    }

    func setUpCell(_ typeOfWine: TypeOfWineEnum) {
        typeOfWineLabel.text = typeOfWine.rawValue
    }

    private func setUpView() {
        wineView.layer.cornerRadius = 20
    }
}
