//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import SwiftUI

struct CarouselView: View {
    @ObservedObject private var controller = CarouselController()
    @EnvironmentObject var router: Router
    @State private var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            Image("main-background")
                .resizable()
                .scaledToFill()
                .blur(radius: 5)
            VStack {
                CarouselText(
                    text: controller.carouselOrder.textContent.texts[currentIndex]
                )
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 300)
                .animation(.easeIn, value: currentIndex)
                .background(
                    .ultraThinMaterial,
                    in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                )
                .padding([.bottom], 20)
                CarouselButtons(
                    nextTapped: {
                        if currentIndex < controller.carouselOrder.textContent.texts.count - 1 {
                            withAnimation { currentIndex += 1   }
                            return
                        }
                        controller.nextPage()
                        currentIndex = 0
                    },
                    previousTapped: currentIndex == 0 ? nil : {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }
                )
            }
            .frame(maxWidth: 900)
            .animation(.spring(), value: controller.carouselOrder)
            .onAppear { controller.didEndPages = router.nextInteraction }
            .environmentObject(controller)
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
