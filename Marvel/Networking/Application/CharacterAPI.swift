//  CharacterAPI.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation

@Observable
class CharacterAPI {
    
    let characterHandler: CharacterHandlerIntf
    
    init(characterHandler: CharacterHandlerIntf) {
        self.characterHandler = characterHandler
    }
    
    func getCharacters(offset: Int, completion: @escaping (Result) -> ()) {
        characterHandler.fetchCharacters(offset: offset) { characterDTO in
            for result in characterDTO.data.results {
                completion(result)
            }
        }
    }
}
