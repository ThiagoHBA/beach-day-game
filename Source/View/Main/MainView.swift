//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import SwiftUI
import AVFoundation

struct MainView: View {
    @ObservedObject private var router = Router()
    @State private var mainPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            switch router.currentInteraction {
                case .play:
                PlayView()
                    .transition(.opacity.animation(Animation.default.delay(2)))
                case .carousel:
                    CarouselView(order:.first)
                    .transition(.opacity.animation(Animation.default.delay(2)))
                    .onAppear { mainPlayer?.stop() }
                case .findItem:
                    FindItemView()
                    .onAppear { playSoundtrack() }
                case .sunscreen:
                    SunscreenView()
                case .final:
                    CarouselView(order: .final)
                    .transition(.opacity.animation(Animation.default.delay(0.5)))
//                    .onDisappear { mainPlayer?.stop() }
            }
        }
        .preferredColorScheme(.light)
        .animation(.spring(), value: router.currentInteraction)
        .environmentObject(router)
    }
    
    func playSoundtrack() {
        guard let url = Bundle.main.url(
            forResource: SongEffect.soundtrack.rawValue, withExtension: "mp3"
        ) else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            mainPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            mainPlayer?.numberOfLoops = -1
            guard let player = mainPlayer else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
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
