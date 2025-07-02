//
//  MainTabbarController.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import Foundation
import UIKit

class MainTabbarController: UITabBarController {
    var incomingArray = [BaseMainTabbar]()
    var controllers = [UIViewController]()
    var customTabbarView = UIView(frame: .zero)
    
    init(incomingArray: [BaseMainTabbar]) {
        self.incomingArray = incomingArray
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("Deinit \(type(of: self))")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
        setupCustomTabbar()
        createTabsFromArray(array: self.incomingArray)
        viewControllers = controllers
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCustomTabbarFrame()
    }
    
    func setupCustomTabbarFrame() {
        let height = view.safeAreaInsets.bottom + 66
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = view.frame.size.height - height
        
        self.tabBar.frame = tabFrame
        self.tabBar.setNeedsLayout()
        self.tabBar.layoutIfNeeded()
        
        customTabbarView.frame = tabBar.frame
    }
    
    func setupTabbar() {
        self.tabBar.backgroundColor = .lightGray
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.6)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    func setupCustomTabbar() {
        customTabbarView.frame = tabBar.frame
        customTabbarView.backgroundColor = .green
        customTabbarView.layer.cornerRadius = 24
        customTabbarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        customTabbarView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        customTabbarView.layer.shadowOffset = CGSize(width: 0, height: -2)
        customTabbarView.layer.shadowOpacity = 1
        customTabbarView.layer.shadowRadius = 12
        customTabbarView.layer.masksToBounds = false
        customTabbarView.removeFromSuperview()
        view.addSubview(customTabbarView)
        view.bringSubviewToFront(tabBar)
    }
    
    private func createTabsFromArray(array: [BaseMainTabbar]) {
        for tab in array {
            let vc = createController(title: tab.title, imageName: tab.imageName, selectedImage: tab.selectedImage, controller: tab.controller, tag: tab.selectedIndex)
            controllers.append(vc)
        }
    }
    
    private func createController(title: String, imageName: String, selectedImage: String, controller: UIViewController, tag: Int) -> UIViewController {
        let viewController = controller
        controller.extendedLayoutIncludesOpaqueBars = false
        controller.tabBarItem.title = title
        controller.tabBarItem.tag = tag
        controller.tabBarItem.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage(systemName: selectedImage)?.withRenderingMode(.alwaysOriginal)
        return viewController
    }
    
    func jumpToTabIndex(_ index: MainTabbarIndex) {
        if let selectedVC = viewControllers?[index.rawValue] {
            selectedViewController = selectedVC
        }
    }
}
