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
        GeometryReader { geo in
            ZStack {
                Image("room")
                    .resizable()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
                
                FindableItem(
                    item: RoomItem(
                        type: .hat,
                        image: "hat"
                    ),
                    roomFrame: geo.frame(in: .global)
                ).position(
                    RoomPosition.wallShelf.getPosition(
                        on: geo.frame(in: .global)
                    )
                )
                
                FindableItem(
                    item: RoomItem(
                        type: .sunglass,
                        image: "sunglass"
                    ),
                    roomFrame: geo.frame(in: .global)
                ).position(
                    RoomPosition.bench.getPosition(
                        on: geo.frame(in: .global)
                    )
                )
                
                FindableItem(
                    item: RoomItem(
                        type: .uvShirt,
                        image: "shirt"
                    ),
                    roomFrame: geo.frame(in: .global)
                ).position(
                    RoomPosition.wardrobe.getPosition(
                        on: geo.frame(in: .global)
                    )
                )
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct FindItemView_Previews: PreviewProvider {
    static var previews: some View {
        FindItemView()
            .previewDevice(PreviewDevice(rawValue: "iPad (10th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
        FindItemView()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
        FindItemView()
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
        FindItemView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        
    }
}
