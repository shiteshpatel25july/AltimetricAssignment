//
//  NetworkWrapper.swift
//  itunesSearch
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh. All rights reserved.
//

import Foundation
import UIKit

class NetworkWrapper {
    
    private static let searchUrl: String = "https://itunes.apple.com/search"
    
    class func searchItunesItem(keyword: String, onSuccess: @escaping ([Album]) -> (), onFailure: @escaping (String) -> ()) {
        
        let urlString = self.searchUrl + "?term=" + keyword
        if let url = urlString.toURL() {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    onFailure(error.localizedDescription)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    if let resultModel = try? decoder.decode(AlbumModel.self, from: data) {
                        if let results = resultModel.results, !results.isEmpty {
                            onSuccess(results)
                        } else {
                            onFailure("No data found")
                        }
                    } else {
                        onFailure("Unable to decode response")
                    }
                } else {
                    onFailure("Unknown error")
                }
            })
            task.resume()
        } else {
            onFailure("Invalid request url")
        }
    }
}


