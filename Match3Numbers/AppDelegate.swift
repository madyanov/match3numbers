//
//  AppDelegate.swift
//  Match3Numbers
//
//  Created by Roman Madyanov on 08.01.2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = GameAssembly.makeViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
