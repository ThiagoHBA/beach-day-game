//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 13/04/23.
//

import SwiftUI


struct SpeakBalloon: View {
    var interaction : InteractionText
    var interactionOver: (() -> Void)?
    var showing: Bool
    @State private var interactionDuration = 0
    @Environment(\.mainWindowSize) var windowSize
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if interaction.type == .speak {
            HStack {
                KidImage(effect: interaction.effect)
                    .offset(x: 20,y: 220)
                    .mask {
                        Rectangle()
                            .cornerRadius(25)
                            .frame(width: 250, height: 250)
                    }
                    .frame(width: 250, height: 250)
                    .padding([.trailing], 40)
                
                Text(interaction.text)
                    .font(Font.system(size: 28))
                    .multilineTextAlignment(.leading)
                    .frame(width: windowSize.width * 0.5)
                    .padding([.trailing], 180)
            }
            
            .ignoresSafeArea(.all)
            .frame(width: windowSize.width, height: 322)
            .foregroundColor(.black)
            .background(.white.opacity(0.9))
            .cornerRadius(25)
            .position(
                x: windowSize.width * 0.5,
                y: windowSize.height - (300/2)
            )
            .overlay {
                Path { path in
                    path.move(to: CGPoint(x: 200, y: 120))
                    path.addLine(to: CGPoint(x: 50, y: 240))
                    path.addLine(to: CGPoint(x: 120, y: 240))
                    path.addLine(to: CGPoint(x: 200, y: 120))
                }
                .fill(.white.opacity(0.9))
                .offset(x: 220, y: windowSize.height - 550)
            }        .animation(.spring(), value: 1.0)
                .overlay(content: {
                    FilledButton(title: "Next", onTap: {
                        interaction.action?()
                        withAnimation(.linear) {
                            interactionOver?()
                        }
                        interactionDuration = 0
                    })
                    .position(
                        x: windowSize.width * 0.92,
                        y: windowSize.height * 0.92
                    )
                })
                .opacity(showing ? 1 : 0)
                .onReceive(timer) { timer in
                    if showing,
                       let duration = interaction.minimumDuration {
                        interactionDuration += 1
                        if interactionDuration > duration {
                            interactionDuration = 0
                            interaction.action?()
                            withAnimation(.linear) { interactionOver?() }
                        }
                    }
                }
        }
        else {
            InformationBalloon(
                interaction: interaction,
                interactionOver: interactionOver,
                showing: showing
            )
        }
    }
}
