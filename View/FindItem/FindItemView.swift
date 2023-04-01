//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import SwiftUI

struct FindItemView: View {
    @EnvironmentObject private var router: Router
    
    var body: some View {
        Button {
            router.nextInteraction()
        } label: {
            Color.green
        }
    }
}

struct FindItemView_Previews: PreviewProvider {
    static var previews: some View {
        FindItemView()
    }
}
