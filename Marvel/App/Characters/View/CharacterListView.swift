//  CharacterListView.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation
import SwiftUI

struct CharacterListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<100) { i in
                    Text("\(i)")
                }
            }
            .navigationTitle("Characters")
        }
    }
}

private struct CharacterRow: View {
    var body: some View {
        Text("Hello World")
    }
}

#Preview {
    CharacterListView()
}
