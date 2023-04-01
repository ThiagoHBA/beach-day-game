//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import SwiftUI

struct FirstView: View {
    @EnvironmentObject private var carouselController: CarouselController
    
    var body: some View {
        Button("CarouselFirstView") {
            carouselController.nextPage()
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
