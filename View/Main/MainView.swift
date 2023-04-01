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
                    CarouselView().transition(.move(edge: .trailing))
                case .findItem:
                    FindItemView()
                case .sunscreen:
                    Button {
                        router.nextInteraction()
                    } label: {
                        Color.yellow
                    }
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
    }
}
