    //
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import SwiftUI

struct FindItemView: View {
    @EnvironmentObject private var router: Router
    @State private var findableItems = RoomItem.generateFindableItems()
    @State private var dummyItems = RoomItem.generateDummyItems()
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("room")
                    .resizable()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
                
                AvatarView(items: $findableItems, protectionProgress: $progress)
                    .frame(
                        width: geo.size.width * 0.2,
                        height: geo.size.height * 0.6
                    )
                
                ForEach(findableItems) { item in
                    FindableItem(item: item)
                        .opacity(item.visible ? 1 : 0.001)
                        .onDrag {
                            return .init(contentsOf: URL(string: item.id.uuidString))!
                        }
                        .position(
                            item.roomPosition.getPosition(on: geo.frame(in: .global))
                        )
                }
                
                ForEach(dummyItems) { item in
                    FindableItem(item: item)
                        .position(item.roomPosition.getPosition(on: geo.frame(in: .global)))
                        .offset(x: item.isDragging ? 10 : 0)
                        .animation(Animation.default.repeatCount(5).speed(6), value: item.isDragging)
                        .onLongPressGesture {
                            let impact = UIImpactFeedbackGenerator(style: .heavy)
                            let index = dummyItems.firstIndex { $0.id == item.id }
                            if let index {
                                print(dummyItems[index].type.description)
                                impact.impactOccurred()
                                withAnimation { dummyItems[index].isDragging.toggle() }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    dummyItems[index].isDragging.toggle()
                                }
                            }
                        }
                }
                
                VStack {
                    HStack {
                        Spacer()
                        ProgressBar(progress: $progress)
                            .frame(width: geo.size.width * 0.25, height: 32)
                    }
                    Spacer()
                }.padding(54)
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
