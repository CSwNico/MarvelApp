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
                    ZStack(alignment: .leading) {
                        NavigationLink(destination: CharacterDetailView(character: character)) { EmptyView() }.opacity(0.0)
                        CharacterRow(character: character)
                            .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                    }
                }
            }
            .listStyle(PlainListStyle())
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
        VStack {
            HStack(alignment: .top) {
                CharacterThumbnailView(character: character)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                VStack {
                    Text(character.name)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.headline)
                    Text(character.information)
                        .font(.subheadline)
                }
                .padding(.leading)
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    CharacterListView()
        .modelContainer(for: [CharacterModel.self])
        .environment(CharacterAPI(characterHandler: CharacterHandler()))
        .environment(ImageAPI(imageHandler: ImageHandler()))
}
