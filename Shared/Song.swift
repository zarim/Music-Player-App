//
//  Song.swift
//  Music-Player-App (iOS)
//
//  Created by Zari McFadden on 7/16/21.
//

import Foundation

struct Song: Codable {
    var id: String
    var name: String
    var artistName: String
    var artworkURL: String
 
    init(id: String, name: String, artistName: String, artworkURL: String) {
        self.id = id
        self.name = name
        self.artworkURL = artworkURL
        self.artistName = artistName
    }
}
