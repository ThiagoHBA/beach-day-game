//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var router = Router()
    
    var body: some View {
        ZStack {
            switch router.currentInteraction {
                case .play:
                    PlayView()
                case .carousel:
                CarouselView(order: .first).transition(.opacity.animation(Animation.default.delay(0.5)))
                case .findItem:
                    FindItemView()
                case .sunscreen:
                    SunscreenView()
                case .final:
                CarouselView(order: .final).transition(.opacity.animation(Animation.default.delay(0.5)))
            }
        }
        .preferredColorScheme(.light)
        .animation(.spring(), value: router.currentInteraction)
        .environmentObject(router)
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPad (10th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
