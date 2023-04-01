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
    
    var body: some View {
        ZStack {
            switch controller.carouselOrder {
                case .first:
                    FirstView()
                case .second:
                    SecondView()
                case .third:
                    Button {
                        controller.nextPage()
                    } label: {
                        Color.purple
                    }
            }
        }
        .animation(.spring(), value: controller.carouselOrder)
        .onAppear { controller.didEndPages = router.nextInteraction }
        .environmentObject(controller)
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
