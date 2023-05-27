//
//  PlayerPresenter.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import UIKit

protocol PlayerPresenterProtocol: AnyObject{
    func getData(_ result: PlayerData)
    func failedToGetData()
    func viewDidLoaded()
    func playerButonClicked()
    func stopMusic()
    func startMusic()
}

class PlayerPresenter{
    weak var view: PlayerViewProtocol?
    var router: PlayerRouterProtocol
    var interactor: PlayerInteractorProtocol
    
    init(view: PlayerViewProtocol? = nil, router: PlayerRouterProtocol, interactor: PlayerInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension PlayerPresenter: PlayerPresenterProtocol{
    func playerButonClicked() {
        interactor.handleMusic()
    }
    func stopMusic() {
        view?.musicStopped()
    }
    func startMusic() {
        view?.musicStarted()
    }
    
    func failedToGetData() {
        view?.failedToGetData()
    }
    func getData(_ result: PlayerData) {
        view?.loadUI(result: result)
    }
    func viewDidLoaded(){
        interactor.passDataToPresenter()
    }
    
}
