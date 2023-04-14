//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 13/04/23.
//

import SwiftUI

struct FilledButton: View {
    let title: String
    var onTap: (() -> Void)?
    
    var body: some View {
        Button { onTap?() }
        label: {
            Text(title)
                .font(Font.system(.title2))
                .bold()
                .padding([.bottom, .top], 16)
                .padding([.leading, .trailing], 52)
                .foregroundColor(.black)
                .background(.yellow)
                .cornerRadius(25)
        }
    }
}

struct FilledButton_Previews: PreviewProvider {
    static var previews: some View {
        FilledButton(title: "Start")
    }
}
