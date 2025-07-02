//
//  FeedPresenter.swift
//  dans_iOS
//
//  Created by Vincent on 02/07/25.
//

import UIKit

class FeedPresenter {
    private let interactor: FeedInteractor
    private let router = FeedRouter()
    
    init(interactor: FeedInteractor) {
        self.interactor = interactor
    }
}
