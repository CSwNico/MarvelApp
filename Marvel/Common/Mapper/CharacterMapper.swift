//  CharacterMapper.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation
import SwiftData

class CharacterMapper {
    static func mapToCharacterModel(character: Result) -> CharacterModel {
        return CharacterModel(
            refID: character.id,
            name: character.name,
            information: character.description,
            modified: Date(),
            resourceURI: character.resourceURI,
            thumbnailPath: character.thumbnail.path.replacing("http", with: "https") + "." + character.thumbnail.thumbnailExtension.rawValue)
    }
}
