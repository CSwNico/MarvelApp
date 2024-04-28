//  LoadingView.swift
//  Marvel
//
//  Created by Nico on 28.04.24.
//  
//

import Foundation
import SwiftUI

struct LoadingView: View {
    
    @State private var isAnimating = false
    
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .resizable()
            .scaledToFit()
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0.0))
            .onAppear {
                withAnimation(foreverAnimation) {
                    isAnimating = true
                }
            }
            .onDisappear {
                isAnimating = false
            }
    }
}

#Preview {
    LoadingView()
}
