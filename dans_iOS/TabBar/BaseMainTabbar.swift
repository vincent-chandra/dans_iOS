//
//  BaseMainTabbar.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

enum MainTabbarIndex: Int {
    case feed
    case bookmark
}


class BaseMainTabbar {
    var title: String = ""
    var imageName: String = ""
    var selectedImage: String = ""
    var controller: UIViewController
    var selectedIndex: Int = 0
    
    init(title: String = "", imageName: String = "", selectedImage: String = "", controller: UIViewController = FeedView(), selectedIndex: Int = 0) {
        self.title = title
        self.imageName = imageName
        self.selectedImage = selectedImage
        self.controller = controller
        self.selectedIndex = selectedIndex
    }
    
    func createTab() -> [BaseMainTabbar] {
        var arrayOfTab = [BaseMainTabbar]()
        
        let vc1 = FeedView()
        let tabOne = BaseMainTabbar(title: "Feed", imageName: "arrow.down.app", selectedImage: "arrow.down.app.fill", controller: vc1, selectedIndex: 0)
        
        let vc2 = BookmarkView()
        let tabTwo = BaseMainTabbar(title: "Bookmark", imageName: "book", selectedImage: "book.fill", controller: vc2, selectedIndex: 1)
        
        arrayOfTab = [tabOne, tabTwo]
        return arrayOfTab
    }
}
