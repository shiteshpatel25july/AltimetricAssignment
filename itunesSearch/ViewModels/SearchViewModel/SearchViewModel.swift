//
//  SearchViewModel.swift
//  itunesSearch
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    // MARK:- Search
    var searchedResult: [Album]?
    
    func searchInItunes(keyword: String, onSuccess: @escaping () -> (), onFailure: @escaping (String) -> ()) {
        NetworkWrapper.searchItunesItem(keyword: keyword, onSuccess: { (result) in
            self.searchedResult = result
            DispatchQueue.main.async {
                onSuccess()
            }
        }, onFailure: { (errorMessage) in
            DispatchQueue.main.async {
                onFailure(errorMessage)
            }
        })
    }
    
    // MARK:- Cart
    var cartItems: [Album]?
    
    func addAlbumInToCart(album: Album) {
        if let _ = self.cartItems {
            self.cartItems?.append(album)
        } else {
            self.cartItems = [album]
        }
    }
    
    func removeAlbumFromCart(album: Album) {
        if let index = self.cartItems?.indexOf(album: album) {
            self.cartItems?.remove(at: index)
        }
    }
}
