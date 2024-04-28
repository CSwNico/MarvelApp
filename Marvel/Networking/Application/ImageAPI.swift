//  ImageAPI.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation

@Observable
class ImageAPI {
    
    private let imageHandler: ImageHandlerIntf
    
    init(imageHandler: ImageHandlerIntf) {
        self.imageHandler = imageHandler
    }
    
    func getImageData(url: URL, completion: @escaping (Data?) -> ()) {
        imageHandler.getData(url: url) { data in
            completion(data)
        }
    }
}
