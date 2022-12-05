//
//  GetStartedView.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 05.12.2022.
//

import UIKit

protocol MoveToAnotherScreenDelegate: AnyObject {
    func moveToLoginScreen() 
}

class GetStartedView: UIView {

    @IBOutlet weak var getStartedView: UIView!
    @IBOutlet weak var shareMomentView: UIView!
    @IBOutlet weak var getStartedButton: UIButton!

    private let kCONTENT_XIB_NAME = "GetStartedView"
    private weak var delegate: MoveToAnotherScreenDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    @IBAction func tappedGetStartedButton(_ sender: UIButton) {
        delegate?.moveToLoginScreen()
    }

    func setUpDelegate(delegate: MoveToAnotherScreenDelegate) {
        self.delegate = delegate
    }

    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        getStartedView.setUpView(self)
        setUpShareMomentView()
        setUpGetStartedButton()
    }

    func setUpShareMomentView() {
        shareMomentView.layer.cornerRadius = 50
    }

    func setUpGetStartedButton() {
        getStartedButton.layer.cornerRadius = 10
    }
}
