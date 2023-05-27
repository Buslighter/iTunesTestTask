//
//  PlayerViewController.swift
//  iTunesTask
//
//  Created by gleba on 26.05.2023.
//

import UIKit
protocol PlayerViewProtocol: AnyObject{
    func viewDidLoaded()
    func loadUI(result: PlayerData)
    func failedToGetData()
    func playerButtonClicked()
    func musicStopped()
    func musicStarted()
    
}
class PlayerViewController: UIViewController{
     var presenter: PlayerPresenterProtocol?
    
    lazy var albumImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8.0
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var trackName: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    lazy var artistName: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .systemGray
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var playButton: UIButton = {
       let button = UIButton()
        button.tintColor = .black
        button.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        button.contentMode = .scaleToFill
        button.addTarget(self , action: #selector(playTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        viewDidLoaded()
        
    }
    private func addSubviews(){
        view.addSubview(albumImageView)
        view.addSubview(trackName)
        view.addSubview(playButton)
        view.addSubview(artistName)
    }
    private func addActions(){
        
    }
    @objc private func playTapped(){
        playerButtonClicked()
    }
    

}
extension PlayerViewController: PlayerViewProtocol{
    func viewDidLoaded() {
        presenter?.viewDidLoaded()
    }
    
    func loadUI(result: PlayerData) {
        self.albumImageView.image = result.image
        self.trackName.text = result.trackName
        self.artistName.text = result.artistName
    }
    func failedToGetData(){
        self.trackName.tintColor = .systemRed
        self.trackName.text = "Failed to load"
    }
    func playerButtonClicked(){
        presenter?.playerButonClicked()
    }
    func musicStopped(){
        self.playButton.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
    }
    func musicStarted(){
        self.playButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
    }
    
}
extension PlayerViewController{
    private func setupConstraints(){
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20),
            albumImageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 40),
            albumImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20),
            albumImageView.widthAnchor.constraint(equalTo: albumImageView.heightAnchor),
            albumImageView.bottomAnchor.constraint(greaterThanOrEqualTo: trackName.topAnchor, constant: -40),
            
            trackName.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            trackName.bottomAnchor.constraint(equalTo: artistName.topAnchor, constant: 4),
            trackName.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            artistName.leadingAnchor.constraint(equalTo: trackName
                .leadingAnchor),
            artistName.trailingAnchor.constraint(equalTo: trackName.trailingAnchor),
            artistName.bottomAnchor.constraint(greaterThanOrEqualTo: playButton.topAnchor, constant: -12),
            
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(greaterThanOrEqualTo: margins.bottomAnchor, constant: -60),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            playButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
}
