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
        Image("texture")
            .resizable(resizingMode: .stretch)
            .frame(width: 65, height: 65)
            .scaledToFill()
            .opacity(point.opacity)
            .clipShape(Circle())
            .position(x: point.location.x, y: point.location.y)
    }
    
}
