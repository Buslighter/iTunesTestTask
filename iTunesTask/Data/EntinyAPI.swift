//
//  EntinyAPI.swift
//  iTunesTask
//
//  Created by gleba on 26.05.2023.
//

import UIKit
struct AnswerForKeyword: Codable {
    let resultCount: Int
    let results: [Result]
}


struct Result: Codable {
    let artistName: String?
    let trackName: String?
    let previewUrl: String?
    let collectionName: String?
    let artworkUrl60: String?
}

struct PlayerData{
    let artistName: String?
    let trackName: String?
    let image: UIImage?
    let audioURL: String?
}
