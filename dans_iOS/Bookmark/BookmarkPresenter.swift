//
//  BookmarkPresenter.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

class BookmarkPresenter {
    private let interactor: BookmarkInteractor
    private let router = BookmarkRouter()
    
    init(interactor: BookmarkInteractor) {
        self.interactor = interactor
    }
}
