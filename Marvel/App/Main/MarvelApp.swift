//  MarvelApp.swift
//  Marvel
//
//  Created by Nico on 27.04.24.
//  
//

import SwiftUI
import SwiftData

@main
struct MarvelApp: App {
    
    private var characterAPI = CharacterAPI(characterHandler: CharacterHandler())
    private var imageAPI = ImageAPI(imageHandler: ImageHandler())
    
    var body: some Scene {
        WindowGroup {
            CharacterListView()
        }
        .modelContainer(for: [CharacterModel.self])
        .environment(characterAPI)
        .environment(imageAPI)
    }
}
