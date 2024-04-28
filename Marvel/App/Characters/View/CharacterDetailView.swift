//  CharacterDetailView.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation
import SwiftUI

struct CharacterDetailView: View {
    
    @State private var showNavbar: Bool = true
    let character: CharacterModel
    
    var body: some View {
        ScrollView {
            header
            
            Text("")
                .padding(.horizontal)
                .padding(.bottom, 75)
        }
        // Set navigation title and customize navigation bar background visibility
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                CharacterNameView(name: character.name)
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
    
    var header: some View {
        GeometryReader { geometry in
            VStack {
                // Check the scroll position to adjust the header image position
                if geometry.frame(in: .global).minY <= 0 {
                    // Header image with parallax effect
                    CharacterThumbnailView(character: character)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(y: (geometry.frame(in: .global).minY / 7))
                        .clipped()
                } else {
                    // Header image without parallax effect
                    CharacterThumbnailView(character: character)
                        .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                        .clipped()
                        .offset(y: -geometry.frame(in: .global).minY)
                }
            }
        }
        .frame(height: 250)
    }
}

struct CharacterNameView: View {
    
    let name: String
    
    var body: some View {
        Text(name)
            .font(.title2)
            .lineLimit(1)
            .padding(6)
            .bold()
            .background(RoundedRectangle(cornerRadius: 45)
                .foregroundStyle(.gray.opacity(0.75)))
            .foregroundStyle(.background)
    }
}
