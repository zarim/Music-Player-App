//
//  Podcasts.swift
//  Music-Player-App
//
//  Created by Zari McFadden on 7/15/21.
//

import Foundation

enum Podcasts: Identifiable {
    var id: Self { self }
    static var allCases: [Podcasts] = [.affordAnything, .chooseFI, .unzipped]
    
    case affordAnything
    case chooseFI
    case unzipped
    
    var title: String {
        switch self {
        case .affordAnything:
            return "Afford Anything"
        case .chooseFI:
            return "Choose FI"
        case .unzipped:
            return "Unzipped"
        }
    }
}
