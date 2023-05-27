//
//  SearchModuleBuilder.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import Foundation

class SearchModuleBuilder{
    static func build() -> SearchViewController{
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(router: router, interactor: interactor)
        let viewController = SearchViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}
