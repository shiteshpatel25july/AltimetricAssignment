//
//  AlbumTableCell.swift
//  itunesSearch
//
//  Created by Shitesh Patel on 15/08/20.
//  Copyright © 2020 Shitesh. All rights reserved.
//

import UIKit

class AlbumTableCell: UITableViewCell {

    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionPrice: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var artworkUrl100: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.trackName.textColor = .black
        self.trackName.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        self.artistName.textColor = .darkGray
        self.artistName.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        self.collectionName.textColor = .darkGray
        self.collectionName.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        self.collectionPrice.textColor = .darkGray
        self.collectionPrice.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        self.releaseDate.textColor = .darkGray
        self.releaseDate.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpCell(album: Album) {
        self.trackName.text = album.trackName
        self.artistName.text = "Artist: " + (album.artistName ?? "")
        self.collectionName.text = "Collection: " + (album.collectionName ?? "")
        self.releaseDate.text = album.displayReleaseDate()
        self.collectionPrice.text = album.displayPrice()
        
        if let urlString = album.artworkUrl100, let url = urlString.toURL() {
            self.artworkUrl100.downloaded(from: url)
        } else {
            self.artworkUrl100.image = nil
        }
    }
}
