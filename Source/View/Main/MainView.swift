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
    @Environment(\.mainWindowSize) var windowSize
    @State private var mainPlayer: AVAudioPlayer?
    @State private var fadeTimer: Timer?
    
    
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
            }
        }
        .preferredColorScheme(.light)
        .animation(.spring(), value: router.currentInteraction)
        .environmentObject(router)
        .overlay {
            ZStack {
                Image("main-background")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 5)
                    .position(x: windowSize.width * 0.5, y: windowSize.height * 0.5)
                CarouselText(text: "Please, use landscape orientation to run playground")
            }
            .frame(width: windowSize.width, height: windowSize.height)
            .opacity(windowSize.width < windowSize.height ? 1 : 0)
        }
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
            mainPlayer?.volume = 0.5
            guard let player = mainPlayer else { return }
            player.play()
            fadeTimer = player.fadeVolume(from: 0, to: 1, duration: 5)
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
