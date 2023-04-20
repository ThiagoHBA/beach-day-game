//
//  PlayViewView.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import SwiftUI

struct PlayView: View {
    @Environment(\.mainWindowSize) var windowSize
    @EnvironmentObject var router: Router
    @State var disableButton = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Image("main-background")
                .resizable()
                .scaledToFill()
                .blur(radius: 2)
            VStack(alignment: .center) {
                VStack {
                    Text("BeachDay")
                        .font(Font.system(size: 160))
                        .bold()
                    Text("The importance of sun care for children")
                        .font(.title)
                        .bold()
                        .padding(0)
                }
                .padding([.bottom], 100)
                FilledButton(title: "Restart") {
                    router.nextInteraction()
                    disableButton.toggle()
                }
                .disabled(disableButton)
            }
        }
        .frame(width: windowSize.width, height: windowSize.height)
        .ignoresSafeArea(.all)
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
