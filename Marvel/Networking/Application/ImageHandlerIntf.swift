//  ImageHandlerIntf.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation

protocol ImageHandlerIntf {
    func getData(url: URL, completion: @escaping (Data?) -> ())
}
