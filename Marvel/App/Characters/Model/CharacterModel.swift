//  CharacterModel.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation
import SwiftData

@Model
class CharacterModel {
    
    let refID: Int
    let name: String
    let information: String
    let modified: Date
    let resourceURI: String
    let thumbnailPath: String
    @Attribute(.externalStorage) var thumbnailImage: Data?
    
    init(refID: Int, name: String, information: String, modified: Date, resourceURI: String, thumbnailPath: String) {
        self.refID = refID
        self.name = name
        self.information = information
        self.modified = modified
        self.resourceURI = resourceURI
        self.thumbnailPath = thumbnailPath
    }
}
