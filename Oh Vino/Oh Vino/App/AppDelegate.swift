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
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "GreetingScreen", bundle: nil)
        let startVC = storyboard.instantiateViewController(withIdentifier: "GreetingScreen")
        window?.rootViewController = UINavigationController(rootViewController: startVC)
        window?.makeKeyAndVisible()
        return true
    }
}

