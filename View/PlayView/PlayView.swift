//
//  PlayViewView.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import SwiftUI

struct PlayView: View {
    
    var body: some View {
        ZStack {
            VStack {
                Text("Beach Day")
                    .font(Font.system(size: 72))
                    .bold()
                Text("A short description")
                    .font(.body)
                    .padding([.bottom], 16)
                Button {
                    
                } label: {
                    Text("Play")
                        .frame(width: 100, height: 50)
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
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
