import SwiftUI

struct InteractionBalloon: View {
    var interaction : InteractionText
    var interactionOver: (() -> Void)?
    var showing: Bool
    @State private var interactionDuration = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(interaction.text)
            .multilineTextAlignment(.center)
            .padding(30)
            .background(.white)
            .cornerRadius(20)
            .shadow(color: .black, radius: 5, y: 5)
            .offset(y: interaction.screenPosition!.screenOffSet)
            .animation(.spring(), value: 1.0)
            .opacity(showing ? 1 : 0)
            .onTapGesture {
                interaction.action?()
                withAnimation(.linear) {
                    interactionOver?()
                }
            }
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
