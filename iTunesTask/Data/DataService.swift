//
//  KeywordDataService.swift
//  iTunesTask
//
//  Created by gleba on 25.05.2023.
//

import UIKit

class DataService{
    static let dataService = DataService()
    
    func getDataForKeyword(keyword: String, completion: @escaping ([Result]) -> Void){
        let defaultURL = "https://itunes.apple.com/search?term="
        var request = URLRequest(url: URL(string: defaultURL+keyword)!)
        request.httpMethod = "GET"
       
            URLSession.shared.dataTask(with: request){ data, response, error in
                DispatchQueue.main.async {
                    if let data = data, let answer = try? JSONDecoder().decode(AnswerForKeyword.self, from: data){
                        completion(answer.results)
                    }else{
                        completion([])
                    }
                }
        }.resume()
    }
    
    func loadImageByURL(url: String, completion:@escaping(UIImage?) -> Void){
        let modifiedUrl = url.replacingOccurrences(of: "60x60", with: "800x800") //API trick, change url60 to url800 resolution
                if let url = URL(string: modifiedUrl){
                    URLSession.shared.dataTask(with: URLRequest(url: url)){data, response, error in
                        DispatchQueue.main.async {
                            if let data, let image = UIImage(data: data){
                                completion(image)
                            }else{
                                completion(nil)
                            }
                        }
                    }.resume()
            }
    }
}
