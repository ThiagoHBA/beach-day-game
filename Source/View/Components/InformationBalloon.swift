import SwiftUI

struct InformationBalloon: View {
    var interaction : InteractionText
    var interactionOver: (() -> Void)?
    var showing: Bool
    @State private var interactionDuration = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(interaction.text)
                .font(Font.system(.title3))
                .multilineTextAlignment(.center)
                .padding([.top], 32)
            HStack {
                FilledButton(title: "OK!") {
                    interaction.action?()
                    withAnimation(.linear) {
                        interactionOver?()
                    }
                }.frame(height: 25)
            }
            .padding([.top], 16)
        }
        .padding(36)
        .background(.white.opacity(0.9))
        .cornerRadius(20)
        .shadow(color: .black, radius: 5, y: 5)
        .offset(y: interaction.screenPosition!.screenOffSet)
        .animation(.spring(), value: 1.0)
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
}
