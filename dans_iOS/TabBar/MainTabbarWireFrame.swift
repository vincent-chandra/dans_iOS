//
//  MainTabbarWireFrame.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

class MainTabbarWireFrame {
    static func makeMainTabbarController() -> UIViewController {
        let tabbar = BaseMainTabbar()
        let tabbarItem = tabbar.createTab()
        let tabbarVC = MainTabbarController(incomingArray: tabbarItem)
        tabbarVC.jumpToTabIndex(.feed)
        let navigation = UINavigationController(rootViewController: tabbarVC)
        return navigation
    }
}
