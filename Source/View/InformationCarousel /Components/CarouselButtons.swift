//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 06/04/23.
//

import SwiftUI

struct CarouselButtons: View {
    var nextTapped: (() -> Void)?
    var previousTapped: (() -> Void)?
    
    var body: some View {
        HStack {
            customButton(title: "Previous", tap: previousTapped)
            .opacity( previousTapped == nil ? 0 : 1)
            Spacer()
            customButton(title: "Next", tap: nextTapped)
        }
    }
    
    @ViewBuilder
    func customButton(title: String, tap: (() -> Void)?) -> some View {
        Button { tap?() }
        label: {
            Text(title)
                .padding(16)
                .foregroundColor(.white)
                .background(.black)
                .cornerRadius(8)
                .clipped()
        }
    }
}

struct CarouselButtons_Previews: PreviewProvider {
    static var previews: some View {
        CarouselButtons()
    }
}
