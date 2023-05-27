//
//  PlayerInteractor.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import UIKit

protocol PlayerInteractorProtocol: AnyObject{
    func passDataToPresenter()
    func handleMusic()
}

class PlayerInteractor: PlayerInteractorProtocol{
    lazy var isPlaying: Bool = false
    func handleMusic() {
        if isPlaying{
            presenter?.stopMusic()
        }else{
            presenter?.startMusic()
        }
        isPlaying.toggle()
    }
    
    func passDataToPresenter() {
        if let result = result{
            presenter?.getData(result)
        }else{
            presenter?.failedToGetData()
        }
    }
    
    weak var presenter: PlayerPresenterProtocol?
    var result: PlayerData?
    init(result: PlayerData?){
        self.result = result
        
    }
}
