//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 15/04/23.
//

import SwiftUI

struct KidImage: View {
    var usingHat = false
    var effect: InteractionEffect?
    private var kidImage: String {
        if usingHat {
            return "kid_idle_hat"
        }
        return "kid_idle"
    }
    
    var body: some View {
        ZStack {
            Image(effect?.associetedImage ?? kidImage)
        }
    }
}
