//
//  SearchRouter.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import Foundation

protocol SearchRouterProtocol: AnyObject{
    func openPlayerVC(answer: PlayerData)
}

class SearchRouter: SearchRouterProtocol{
    func openPlayerVC(answer: PlayerData) {
        let vc = PlayerModuleBuilder.build(result: answer)
        view?.present(vc, animated: true, completion: nil)
    }
    weak var view: SearchViewController?
}
