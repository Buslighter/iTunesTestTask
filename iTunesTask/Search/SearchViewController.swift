//
//  ViewController.swift
//  iTunesTask
//
//  Created by gleba on 24.05.2023.
//

import UIKit

protocol SearchViewProtocol: AnyObject{
    func showList(result: [Result])
    func startSearch(keyword: String)
    func showWarningAboutLength()
    func toggleActivityIndicator()
    func trackTapped(result: Result)
}

final class SearchViewController: UIViewController, UISearchBarDelegate {
    var presenter: SearchPresenterProtocol?
    private var resultData: [Result]?
    
    lazy var searchSongView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск, не менее 3 символов"
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    lazy var cancelButton: UIButton = {
       let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var songsTableView: UITableView = {
       let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    lazy var redLabel: UILabel = {
        let label = UILabel()
        label.text = "Минимум 3 символа и только EN буквы и символы"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 10)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        addActions()
    }

    private func addSubviews(){
        view.addSubview(searchSongView)
        view.addSubview(cancelButton)
        view.addSubview(songsTableView)
        view.addSubview(redLabel)
        view.addSubview(activityIndicator)
    }
    private func addActions(){
        self.searchSongView.delegate = self
        self.songsTableView.delegate = self
        self.songsTableView.dataSource = self
        self.songsTableView.register(SongTableViewCell.self, forCellReuseIdentifier: "cell")
        self.songsTableView.keyboardDismissMode = .onDrag
    }
    @objc private func cancelTapped(){
        redLabel.isHidden = true
        self.searchSongView.endEditing(true)
        self.searchSongView.text = ""
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startSearch(keyword: searchSongView.text ?? "")
        self.searchSongView.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        redLabel.isHidden = true
    }

}
extension SearchViewController{
    private func setupConstraints(){
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            searchSongView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            searchSongView.topAnchor.constraint(equalTo: margins.topAnchor),
            
            redLabel.topAnchor.constraint(equalTo: searchSongView.bottomAnchor, constant: 4),
            redLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            
            cancelButton.leadingAnchor.constraint(equalTo: searchSongView.trailingAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -8),
            cancelButton.centerYAnchor.constraint(equalTo: searchSongView.centerYAnchor),
        
            songsTableView.topAnchor.constraint(equalTo: redLabel.bottomAnchor, constant: 8),
            songsTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 8),
            songsTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            songsTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: songsTableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: songsTableView.centerYAnchor)
            
        ])
    }
}
extension SearchViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SongTableViewCell
        let result = self.resultData?[indexPath.row]
        cell.artistName.text = result?.artistName
        cell.trackName.text = result?.trackName ?? result?.collectionName
        cell.setImage(url: result?.artworkUrl60 ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return songsTableView.frame.size.height/6
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = songsTableView.cellForRow(at: indexPath)
        trackTapped(result: resultData![indexPath.row])
        cell?.isSelected = false
    }
}

extension SearchViewController: SearchViewProtocol{
    
    func trackTapped(result: Result) {
        self.presenter?.transformData(result: result)
    }
    
    func toggleActivityIndicator(){
        DispatchQueue.main.async {
            if self.activityIndicator.isAnimating{
                self.activityIndicator.stopAnimating()
            }else{
                self.activityIndicator.startAnimating()
            }
        }
    }
    func showWarningAboutLength() {
        redLabel.isHidden = false
    }
    func startSearch(keyword: String) {
        presenter?.startLoadData(keyword: keyword)
    }
    func showList(result: [Result]) {
        DispatchQueue.main.async {
            self.resultData = result
            self.songsTableView.reloadData()
        }
    }
    
    
}
