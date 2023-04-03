    //
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import SwiftUI

struct FindItemView: View {
    @EnvironmentObject private var router: Router
    @State private var findableItems: [RoomItem] = RoomItem.generateFindableItems()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("room")
                    .resizable()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
                
                AvatarView(items: $findableItems)
                    .frame(
                        width: geo.size.width * 0.2,
                        height: geo.size.height * 0.6
                    )
                
                ForEach(findableItems, id: \.self) { item in
                    FindableItem(item: item)
                        .opacity(item.visible ? 1 : 0.001)
                        .onDrag { return .init(contentsOf: URL(string: item.id.uuidString))! }
                        .position(
                            item.roomPosition.getPosition(on: geo.frame(in: .global))
                        )
                }
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
