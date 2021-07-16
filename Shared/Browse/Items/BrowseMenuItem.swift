//
//  BrowseMenuItem.swift
//  Music-Player-App
//
//  Created by Zari McFadden on 7/15/21.
//

import Foundation

enum BrowseMenuItem: Identifiable {
    var id: Self { self }
    static var allCases: [BrowseMenuItem] = [.moods, .artists, .podcasts]
    
    case moods
    case artists
    case podcasts
    
    var title: String {
        switch self {
        case .moods:
            return "MOODS"
        case .artists:
            return "ARTISTS"
        case .podcasts:
            return "PODCASTS"
        }
    }
}
