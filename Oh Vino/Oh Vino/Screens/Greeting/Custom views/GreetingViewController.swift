//
//  GreetingViewController.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 05.12.2022.
//

import UIKit

class GreetingViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    private let welcomeView = WelcomeView()
    private let descriptionView = DescriptionView()
    private let getStartedView = GetStartedView()

    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedView.setUpDelegate(delegate: self)
        navigationController?.navigationBar.isHidden = true
        setUpScrollView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupContentHeight()
    }

    private func setUpScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.addSubview(welcomeView)
        scrollView.addSubview(descriptionView)
        scrollView.addSubview(getStartedView)
    }

    private func setupContentHeight() {
        let height = scrollView.frame.height
        welcomeView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: height)
        descriptionView.frame = CGRect(x: view.frame.width, y: 0, width: view.frame.size.width, height: height)
        getStartedView.frame = CGRect(x: 2 * view.frame.width, y: 0, width: view.frame.size.width, height: height)
        scrollView.contentSize = CGSize(width: 3 * view.frame.width, height: height)
    }
}

// MARK: -
// MARK: - ScrollViewDelegate

extension GreetingViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(view.frame.size.width))
    }
}

// MARK: -
// MARK: - MoveToAnotherScreenDelegate

extension GreetingViewController: MoveToAnotherScreenDelegate {
    func moveToLoginScreen() {
        let controller = viewController(storyboardName: "LoginScreen", identifier: "LoginScreen", isNavigation: false)
        navigationController?.pushViewController(controller, animated: true)
    }
}


