//
//  Song.swift
//  Music-Player-App (iOS)
//
//  Created by Zari McFadden on 7/16/21.
//

import Foundation

struct Song: Codable, Identifiable {
    var id: String
    var name: String
    var album: String
    var artistName: String
    var artworkURL: String
    var duration: Int
    var durationFormatted: String
    var bgColor: String
    var textColor: String
    var love: Bool?
 
    init(id: String, name: String, album: String, artistName: String, artworkURL: String, duration: Int, bgColor: String, textColor: String) {
        self.id = id
        self.name = name
        self.artworkURL = artworkURL
        self.artistName = artistName
        self.duration = duration
        self.durationFormatted = TimeInterval(duration.msToSeconds).minuteSecond
        self.bgColor = bgColor
        self.textColor = textColor
        self.album = album
    }
}

extension TimeInterval {
    var minuteSecond: String {
        return String(format:"%d:%02d", minute, second)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
}

extension Int {
    var msToSeconds: Int {
        return self / 1000
    }
}
