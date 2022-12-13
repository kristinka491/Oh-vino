//
//  AppDelegate.swift
//  Oh Vino
//
//  Created by Vlad Birukov on 01.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpStartScreen()
        setUpNavigationBar()
        return true
    }

    private func showScreen(with storyboardName: String, viewControllerName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName)

        let navigationController = UINavigationController(rootViewController: viewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func setUpStartScreen() {
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUserOnboarded) {
            if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUserRemembered),
               UserDefaults.standard.bool(forKey: UserDefaultsKeys.isUserLoggedIn) {
                self.showScreen(with: "TabBarScreen", viewControllerName: "TabBarScreen")
            } else {
                self.showScreen(with: "LoginScreen", viewControllerName: "LoginScreen")
            }
        } else {
            self.showScreen(with: "GreetingScreen", viewControllerName: "GreetingScreen")
        }
    }

    private func setUpNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGray
    }
}

