//
//  Album.swift
//  itunesSearch
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh. All rights reserved.
//

import Foundation

class Album: Decodable {
    var artistName: String?
    var trackName: String?
    var collectionName: String?
    var collectionPrice: Double?
    var releaseDate: String?
    var artworkUrl100: String?
    var currency: String?
    var collectionId: Double?
    
    func displayReleaseDate() -> String {
        let result = "Date: "
        guard let releaseDate = self.releaseDate else { return result}
        guard let toDate = releaseDate.toDate() else { return result}
        guard let toString = toDate.toString() else { return result}
        return result + toString
    }
    
    func displayPrice() -> String {
        let price = self.collectionPrice ?? 0
        let currency = self.currency ?? ""
        return "Price: " + currency + " " + String(format: "%.2f", price)
    }
}

class AlbumModel: Decodable {
    var resultCount: Int?
    var results: [Album]?
}
