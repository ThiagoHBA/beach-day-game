//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 15/04/23.
//

import SwiftUI

struct KidImage: View {
    var removeHair: Bool = false
    
    var body: some View {
        ZStack {
            Image("kid_idle01")
            if !removeHair {
                GeometryReader { geo in
                    Image("kid_hair")
                        .position(
                            x: geo.frame(in: .global).width * 0.47,
                            y: geo.frame(in: .global).height * 0.12
                        )
                }
            }
            
        }
    }
}
