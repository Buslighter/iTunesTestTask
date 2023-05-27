//
//  SearchInteractor.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import Foundation

protocol SearchInteractorProtocol: AnyObject{
    func loadData(keyword: String)
    func transformData(result: Result)
}

class SearchInteractor: SearchInteractorProtocol{
    func transformData(result: Result) {
        
        DataService().loadImageByURL(url: result.artworkUrl100 ?? "", completion: {[weak self] image in
            var trackName = result.trackName
            if result.trackName == nil{
                trackName = result.collectionName
            }
            let data = PlayerData(artistName: result.artistName, trackName: trackName, image: image)
            self?.presenter?.passTransofrmedDataToVc(answer: data)
        })
    }
    
    weak var presenter: SearchPresenterProtocol?
    private func checkIfKeywordValid(keyword: String) -> Bool{
        if keyword.count<3{
            return false
        }
        for i in keyword{
            if ((i >= "а" && i <= "я") || (i >= "А" && i <= "Я")){
                return false
            }
        }
        return true
    }
    func loadData(keyword: String) {
        if checkIfKeywordValid(keyword: keyword){
            DataService().getDataForKeyword(keyword: keyword, completion: { [weak self] result in
                self?.presenter?.didLoad(result: result)
            })
        }else{
            presenter?.loadFail()
        }
    }
}
