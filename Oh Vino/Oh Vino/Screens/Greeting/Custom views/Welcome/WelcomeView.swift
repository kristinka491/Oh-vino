//
//  WelcomeView.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 05.12.2022.
//

import UIKit

class WelcomeView: UIView {

    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var helloView: UIView!

    private let kCONTENT_XIB_NAME = "WelcomeView"

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
        welcomeView.setUpView(self)
        setUpHelloView()
    }

    func setUpHelloView() {
        helloView.layer.cornerRadius = 50
    }
}
