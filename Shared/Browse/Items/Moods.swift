//
//  Moods.swift
//  Music-Player-App
//
//  Created by Zari McFadden on 7/15/21.
//

import Foundation

enum Moods: Identifiable {
    var id: Self { self }
    static var allCases: [Moods] = [.chillOut, .study, .soulful, .pop]
    
    case chillOut
    case study
    case soulful
    case pop
    
    var title: String {
        switch self {
        case .chillOut:
            return "Chill Out"
        case .study:
            return "Study"
        case .soulful:
            return "Soulful"
        case .pop:
            return "Pop"
        }
    }
}
