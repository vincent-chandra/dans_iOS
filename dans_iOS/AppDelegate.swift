//
//  AppDelegate.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        makeViewAndSetupAppearance()
        return true
    }

}

extension AppDelegate {
    func makeViewAndSetupAppearance() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabbarWireFrame.makeMainTabbarController()
        window?.makeKeyAndVisible()
    }
}
