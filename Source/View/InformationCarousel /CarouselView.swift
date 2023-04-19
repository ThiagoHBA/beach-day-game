//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import SwiftUI

struct CarouselView: View {
    @EnvironmentObject var router: Router
    @State private var currentIndex: Int = 0
    @State var order: CarouselViewOrder
    @Environment(\.mainWindowSize) var windowSize
    
    var body: some View {
        ZStack {
            Image("main-background")
                .resizable()
                .scaledToFill()
                .blur(radius: 5)
                .position(x: windowSize.width * 0.5, y: windowSize.height * 0.5)
            
            VStack {
                CarouselText(
                    text: order.textContent.texts[currentIndex]
                )
                .frame(width: windowSize.width * 0.8, height: 300)
                .animation(.easeIn, value: currentIndex)
                .background(
                    .thinMaterial,
                    in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                )
                .padding([.bottom], 20)
                CarouselButtons(
                    nextTapped: {
                        if currentIndex < order.textContent.texts.count - 1 {
                            withAnimation { currentIndex += 1   }
                            return
                        }
                        router.nextInteraction()
                    },
                    previousTapped: currentIndex == 0 ? nil : {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                )
            }
            .frame(maxWidth: 900)
            .animation(.spring(), value: order)
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(order: .first)
    }
}
