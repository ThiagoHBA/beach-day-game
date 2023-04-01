//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import SwiftUI

struct SecondView: View {
    @EnvironmentObject private var carouselController: CarouselController
    
    var body: some View {
        Button("CarouselSecondView") {
            carouselController.nextPage()
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
