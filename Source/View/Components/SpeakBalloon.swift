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
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if interaction.type == .speak {
            GeometryReader { geo in
                HStack {
                    Image("kid_idle01")
                        .offset(y: 200)
                        .mask {
                            Rectangle()
                                .cornerRadius(25)
                                .frame(width: 200, height: 200)
                                .padding(40)
                        }
                    
                    Text(interaction.text)
                        .font(Font.system(size: 26))
                        .multilineTextAlignment(.leading)
                        .frame(width: geo.size.width * 0.6)
                        .padding([.trailing], 150)
                }
                .frame(width: geo.size.width, height: 322)
                .foregroundColor(.black)
                .background(.white.opacity(0.9))
                .cornerRadius(25)
                .position(
                    x: geo.frame(in: .global).midX,
                    y: geo.frame(in: .global).maxY - 150
                )
                .overlay {
                    Path { path in
                        path.move(to: CGPoint(x: 200, y: 120))
                        path.addLine(to: CGPoint(x: 50, y: 240))
                        path.addLine(to: CGPoint(x: 120, y: 240))
                        path.addLine(to: CGPoint(x: 200, y: 120))
                    }
                    .fill(.white.opacity(0.9))
                    .offset(x: 220, y: geo.frame(in: .global).maxY - 550)
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
                            x: geo.frame(in: .local).width * 0.92,
                            y: geo.frame(in: .local).height * 0.92
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
            
        } else {
            InformationBalloon(
                interaction: interaction,
                interactionOver: interactionOver,
                showing: showing
            )
            
        }
    }
}
