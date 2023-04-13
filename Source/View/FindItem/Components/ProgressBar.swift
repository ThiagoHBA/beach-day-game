//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 05/04/23.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            Capsule()
                .foregroundColor(.gray)
                .overlay {
                    Capsule()
                        .foregroundColor(.green)
                        .padding(8)
                        .frame(width: geo.size.width * progress)
                        .position(x: (geo.size.width * progress)/2, y: geo.size.height/2)
                }
                .shadow(radius: 8)
                .onChange(of: progress) { newValue in
                    if newValue > 1 { progress = 1 }
                    if newValue < 0 { progress = 0 }
                }
        }
    }
}
