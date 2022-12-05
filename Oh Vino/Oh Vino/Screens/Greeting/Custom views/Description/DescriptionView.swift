//
//  DescriptionView.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 05.12.2022.
//

import UIKit

class DescriptionView: UIView {

    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var wineCollectionView: UIView!

    private let kCONTENT_XIB_NAME = "DescriptionView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        descriptionView.setUpView(self)
        setUpwineCollectionView()
    }

    func setUpwineCollectionView() {
        wineCollectionView.layer.cornerRadius = 50
    }
}
