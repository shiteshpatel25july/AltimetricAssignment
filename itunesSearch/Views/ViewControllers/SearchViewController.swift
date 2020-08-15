//
//  SearchViewController.swift
//  itunesSearch
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var interactor: SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.interactor = SearchViewModel()
        
        self.searchBar.placeholder = "Search album"
        self.title = "Search Album"
        
        /// Add cart button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cart", style: .plain, target: self, action: #selector(self.openCart))

        /// Register cell
        self.tableView.register(UINib(nibName: "AlbumTableCell", bundle: nil), forCellReuseIdentifier: "AlbumTableCell")
        
        /// Remove seperator lines of empty cell
        self.tableView.tableFooterView = UIView()
        
        ///populate all data
        search(keyword: "all")
    }
    
    /// Navigate to Cart Srceen
    @objc private func openCart() {
        if let cartVC = self.storyboard?.instantiateViewController(identifier: "CartViewController") as? CartViewController {
            cartVC.cartItems = self.interactor?.cartItems
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    
    /// Api Call
    private func search(keyword: String) {
        self.interactor?.searchInItunes(keyword: keyword, onSuccess: {
            self.tableView.reloadData()
            
        }, onFailure: { [weak self] (result) in
            
            /// Display error alert
            let alert = UIAlertController(title: nil, message: result, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        })
    }
}

// MARK:- UISearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let keyword = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !keyword.isEmpty {
            self.search(keyword: keyword)
        }
    }
}

// MARK:- UITableView Delegate & DataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.interactor?.searchedResult {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableCell", for: indexPath) as? AlbumTableCell {
            if let list = self.interactor?.searchedResult {
                let album = list[indexPath.row]
                cell.setUpCell(album: album)
                
                if let isContains = self.interactor?.cartItems?.isContains(album: album), isContains {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = self.interactor?.searchedResult {
            let album = list[indexPath.row]
            if let isContains = self.interactor?.cartItems?.isContains(album: album), isContains {
                self.interactor?.removeAlbumFromCart(album: album)
            } else {
                self.interactor?.addAlbumInToCart(album: album)
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
