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
        Image("sunscreen_texture")
            .resizable(resizingMode: .stretch)
            .frame(width: 120, height: 120)
            .scaledToFill()
            .opacity(point.opacity)
            .clipShape(Circle())
            .position(x: point.location.x, y: point.location.y)
    }
    
}
