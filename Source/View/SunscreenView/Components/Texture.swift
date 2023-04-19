//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 06/04/23.
//

import SwiftUI

import SwiftUI

struct SunscreenTexture: View {
    var point: Point
    
    var body: some View {
        GeometryReader { proxy in
            Image("sunscreen_texture")
                .resizable(resizingMode: .stretch)
                .frame(width: proxy.size.width * 0.08, height: proxy.size.height * 0.08)
                .scaledToFill()
                .opacity(point.opacity)
                .clipShape(Circle())
                .position(x: point.location.x, y: point.location.y)
        }
    }
    
}
