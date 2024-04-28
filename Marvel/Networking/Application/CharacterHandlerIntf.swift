//  CharacterHandlerIntf.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation

protocol CharacterHandlerIntf {
    func fetchCharacters(offset: Int, completion: @escaping (CharactersDTO) -> ())
}
