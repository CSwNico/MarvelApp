//  ImageHandler.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation

class ImageHandler: ImageHandlerIntf {
    
    func getData(url: URL, completion: @escaping (Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, respone, error) in
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
