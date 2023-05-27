//
//  SongTableViewCell.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    lazy var albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var trackName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Song Name"
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    lazy var artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.minimumScaleFactor = 0.5
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
//MARK: Override
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.albumImage.image = nil
            self.activityIndicator.startAnimating()
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        self.backgroundColor = .none
        self.addSubview(container)
        container.addSubview(albumImage)
        container.addSubview(trackName)
        container.addSubview(artistName)
        container.addSubview(activityIndicator)
    }
    func setImage(url: String){
            self.activityIndicator.stopAnimating()
            DataService().loadImageByURL(url: url, completion: { [weak self] image in
                DispatchQueue.main.async {
                    self?.albumImage.image = image
                    self?.activityIndicator.stopAnimating()
                }
            })
    }
    
}
extension SongTableViewCell{
    private func setConstraints(){
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            activityIndicator.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: container.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            activityIndicator.widthAnchor.constraint(equalTo: activityIndicator.heightAnchor),
            
            albumImage.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor),
            albumImage.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor),
            albumImage.topAnchor.constraint(equalTo: activityIndicator.topAnchor),
            albumImage.bottomAnchor.constraint(equalTo: activityIndicator.bottomAnchor),
            
            
            trackName.leadingAnchor.constraint(equalTo: activityIndicator.trailingAnchor, constant: 4),
            trackName.topAnchor.constraint(equalTo: activityIndicator.topAnchor),
            trackName.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            artistName.leadingAnchor.constraint(equalTo: trackName.leadingAnchor),
            artistName.topAnchor.constraint(lessThanOrEqualTo: trackName.bottomAnchor, constant: 8),
            artistName.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor),
            artistName.trailingAnchor.constraint(equalTo: container.trailingAnchor)
            
            
        
        ])
    }
}

