//
//  Artists.swift
//  Music-Player-App
//
//  Created by Zari McFadden on 7/15/21.
//

import Foundation

enum Artists: Identifiable {
    var id: Self { self }
    static var allCases: [Artists] = [.beyonce, .arianaGrande, .jpCooper, .mariahTheScientist]
    
    case beyonce
    case arianaGrande
    case jpCooper
    case mariahTheScientist
    
    var title: String {
        switch self {
        case .beyonce:
            return "Beyonce"
        case .arianaGrande:
            return "Ariana Grande"
        case .jpCooper:
            return "JP Cooper"
        case .mariahTheScientist:
            return "Mariah The Scientist"
        }
    }
}
