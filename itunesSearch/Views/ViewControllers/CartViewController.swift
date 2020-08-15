//
//  CartViewController.swift
//  itunesSearch
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var cartItems: [Album]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cart"
        
        /// Register cell
        self.tableView.register(UINib(nibName: "AlbumTableCell", bundle: nil), forCellReuseIdentifier: "AlbumTableCell")
        
        /// Remove seperator lines of empty cell
        self.tableView.tableFooterView = UIView()
    }
}

// MARK:- UITableView Delegate & DataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.cartItems {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableCell", for: indexPath) as? AlbumTableCell {
            if let list = self.cartItems {
                let album = list[indexPath.row]
                cell.setUpCell(album: album)
            }
            return cell
        }
        return UITableViewCell()
    }
}
