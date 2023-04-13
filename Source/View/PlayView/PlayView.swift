//
//  PlayViewView.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import SwiftUI

struct PlayView: View {
    @EnvironmentObject var router: Router
    @State var disableButton = false
    
    var body: some View {
        ZStack {
            Image("main-background")
                .resizable()
                .scaledToFill()
                .blur(radius: 2)
            VStack {
                VStack {
                    Text("BeachDay")
                        .font(Font.system(size: 160))
                        .bold()
                    Text("The importance of sun care for children")
                        .font(.title)
                        .bold()
                        .padding(0)
                }
                .padding([.top, .bottom], 200)
                FilledButton(title: "Start") {
                    router.nextInteraction()
                    disableButton.toggle()
                }
                .disabled(disableButton)
            }
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
            .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
