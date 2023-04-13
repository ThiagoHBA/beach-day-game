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
        if previousTapped == nil {
            FilledButton(
                title: "Next",
                onTap: nextTapped
            )
        } else {
            HStack {
                FilledButton(
                    title:  "Previous",
                    onTap: previousTapped
                )
                .opacity( previousTapped == nil ? 0 : 1)
                Spacer()
                FilledButton(
                    title: "Next",
                    onTap: nextTapped
                )
            }
        }
    }
    
}

struct CarouselButtons_Previews: PreviewProvider {
    static var previews: some View {
        CarouselButtons()
    }
}
