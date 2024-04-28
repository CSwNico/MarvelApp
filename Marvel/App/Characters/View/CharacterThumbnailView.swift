//  CharacterThumbnailView.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation
import SwiftUI

struct CharacterThumbnailView: View {
    
    @Bindable var character: CharacterModel
    @Environment(ImageAPI.self) private var imageAPI
    
    var body: some View {
        if let thumbnailImage = character.thumbnailImage {
            Image(uiImage: UIImage(data: thumbnailImage)!)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
                .onAppear {
                    loadImage()
                }
        }
    }
    
    func loadImage() {
        imageAPI.getImageData(url: URL(string: character.thumbnailPath)!) { imageData in
            character.thumbnailImage = imageData
        }
    }
}
