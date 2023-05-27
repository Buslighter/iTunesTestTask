//
//  SearchPresenter.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject{
    func startLoadData(keyword: String)
    func loadFail()
    func didLoad(result: [Result])
    func transformData(result: Result)
    func passTransofrmedDataToVc(answer: PlayerData)
}

class SearchPresenter{
    weak var view: SearchViewProtocol?
    var router: SearchRouterProtocol
    var interactor: SearchInteractorProtocol
    
    init(view: SearchViewProtocol? = nil, router: SearchRouterProtocol, interactor: SearchInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension SearchPresenter: SearchPresenterProtocol{
    func passTransofrmedDataToVc(answer: PlayerData) {
        router.openPlayerVC(answer: answer)
    }
    
    func transformData(result: Result) {
        interactor.transformData(result: result)
    }
    
    func startLoadData(keyword: String){
        interactor.loadData(keyword: keyword)
        view?.toggleActivityIndicator()
    }
    func loadFail() {
        view?.showWarningAboutLength()
        view?.toggleActivityIndicator()
    }
    func didLoad(result: [Result]) {
        view?.showList(result: result)
        view?.toggleActivityIndicator()
    }
    
}
