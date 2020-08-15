//
//  Extensions.swift
//  itunesSearch
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func toURL() -> URL? {
        guard let urlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil}
        return URL(string: urlString)
    }
    
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter.date(from: self)
    }
}

extension Date {
    func toString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        return formatter.string(from: self)
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = link.toURL() else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension Collection where Self == [Album] {
    func isContains(album: Album) -> Bool {
        for item in self {
            if item.collectionId == album.collectionId {
                return true
            }
        }
        return false
    }
    
    func indexOf(album: Album) -> Int? {
        for (index,item) in self.enumerated() {
            if item.collectionId == album.collectionId {
                return index
            }
        }
        return nil
    }
}
