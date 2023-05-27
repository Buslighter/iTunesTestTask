//
//  PlayerInteractor.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import UIKit
import AVFoundation

protocol PlayerInteractorProtocol: AnyObject{
    func passDataToPresenter()
    func handleMusic()
}

class PlayerInteractor: PlayerInteractorProtocol{
    private lazy var isPlaying: Bool = false
    private var player: AVQueuePlayer? //Player чтобы играть музыку
    private var playerLooper: AVPlayerLooper?
    
    func handleMusic() {
        if isPlaying{
            self.player?.pause()
            presenter?.stopMusic()
        }else{
            self.player?.play()
            presenter?.startMusic()
        }
        isPlaying.toggle()
    }
    
    func passDataToPresenter() {
        if let result = result{
            initAVPlayer(url: result.audioURL)
            presenter?.getData(result)
        }else{
            presenter?.failedToGetData()
        }
    }
    
    private func initAVPlayer(url: String?) {
        let asset = AVAsset(url: URL(string: url!)!) // получаем ассет по url
        let playerItem = AVPlayerItem(asset: asset) // создаем айте музыки из ассета
        self.player = AVQueuePlayer(playerItem: playerItem)
        self.playerLooper = AVPlayerLooper(player: self.player!, templateItem: playerItem) //Зацикливаем песню
    }
        
    weak var presenter: PlayerPresenterProtocol?
    var result: PlayerData?
    init(result: PlayerData?){
        self.result = result
        
    }
}
