//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 06/04/23.
//

import SwiftUI

struct CarouselText: View {
    let text: String
    
    var body: some View {
        Text(.init(text))
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .padding(42)
            .background(
                .thinMaterial,
                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
    }
}

struct CarouselText_Previews: PreviewProvider {
    static var previews: some View {
        CarouselText(text: "")
    }
}
