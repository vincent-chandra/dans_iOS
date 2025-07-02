//
//  BookmarkRouter.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

class BookmarkRouter {
    func showView() -> BookmarkView {
        let interactor = BookmarkInteractor()
        let presenter = BookmarkPresenter(interactor: interactor)
        
        let storyboardId = String(describing: BookmarkView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? BookmarkView else {
            fatalError("Error loading Storyboard")
        }
        view.presenter = presenter
        return view
    }
}
