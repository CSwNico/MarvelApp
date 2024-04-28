//  CharacterListView.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation
import SwiftUI
import SwiftData

struct CharacterListView: View {
    
    @Query(sort: [
        SortDescriptor(\CharacterModel.name)
    ])
    private var characters: [CharacterModel]
    
    @Environment(CharacterAPI.self) private var characterAPI
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            List {
                ForEach(characters) { character in
                    CharacterRow(character: character)
                }
            }
            .navigationTitle("Characters")
            .onAppear {
                if characters.count == 0 {
                    loadCharacters()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        refreshData()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                    })
                }
            }
        }
    }
    
    func loadCharacters() {
        characterAPI.getCharacters(offset: 0) { character in
            let characterModel = CharacterMapper.mapToCharacterModel(character: character)
            modelContext.insert(characterModel)
        }
    }
    
    func refreshData() {
        for character in characters {
            modelContext.delete(character)
        }
        loadCharacters()
    }
}

private struct CharacterRow: View {
    
    @Bindable var character: CharacterModel
    
    var body: some View {
        HStack {
            CharacterThumbnailView(character: character)
            Text(character.name)
        }
    }
}

#Preview {
    CharacterListView()
        .modelContainer(for: [CharacterModel.self])
        .environment(CharacterAPI(characterHandler: CharacterHandler()))
        .environment(ImageAPI(imageHandler: ImageHandler()))
}
