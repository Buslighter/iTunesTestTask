//
//  PlayerModuleBuilder.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import Foundation

class PlayerModuleBuilder{
    static func build(result: PlayerData?) -> PlayerViewController{
        let interactor = PlayerInteractor(result: result)
        let router = PlayerRouter()
        let presenter = PlayerPresenter(router: router, interactor: interactor)
        let viewController = PlayerViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        return viewController
    }
}
