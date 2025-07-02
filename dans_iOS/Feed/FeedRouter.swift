//
//  FeedRouter.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

class FeedRouter {
    func showView() -> FeedView {
        let interactor = FeedInteractor()
        let presenter = FeedPresenter(interactor: interactor)
        
        let storyboardId = String(describing: FeedView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? FeedView else {
            fatalError("Error loading Storyboard")
        }
        view.presenter = presenter
        return view
    }
}
