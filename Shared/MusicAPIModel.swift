//
//  MusicAPIModel.swift
//  Music-Player-App (iOS)
//
//  Created by Zari McFadden on 7/20/21.
//

import Foundation

struct MusicAPIModel: Codable {
    var results: Results
    var meta: Meta
}

struct Results: Codable {
    var songs: Songs
}

struct Meta: Codable {
    var results: MetaResults
}

struct MetaResults: Codable {
    var rawOrder: [String]
    var order: [String]
}

struct Songs: Codable {
    var next: String
    var data: [SongData]
    var href: String
}

struct SongData: Codable {
    var id: String
    var type: String
    var attributes: SongAttributes
    var href: String
}

struct SongAttributes: Codable {
    var name: String
    var playParams: PlayParams
    var composerName: String?
    var artwork: Artwork
    var trackNumber: Int
    var albumName: String
    var durationInMillis: Int
    var url: String
    var contentRating: String?
    var artistName: String
    var genreNames: [String]
    var isrc: String
    var previews: [Previews]
    var hasLyrics: Bool
    var discNumber: Int
    var releaseDate: String
}

struct PlayParams: Codable {
    var id: String
    var kind: String
}

struct Artwork: Codable {
    var textColor1: String
    var height: Int
    var bgColor: String
    var textColor4: String
    var width: Int
    var textColor3: String
    var url: String
    var textColor2: String
}

struct Previews: Codable {
    var url: String
}
