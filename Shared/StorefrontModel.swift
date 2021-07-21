//
//  StorefrontModel.swift
//  Music-Player-App (iOS)
//
//  Created by Zari McFadden on 7/20/21.
//

import Foundation

struct StorefrontModel: Codable {
    var data: [Data]
}

struct Data: Codable {
    var attributes: Attributes
    var href: String
    var id: String
    var type: String
}

struct Attributes: Codable {
    var defaultLanguageTag: String
    var name: String
    var supportedLanguageTags: [String]
}
