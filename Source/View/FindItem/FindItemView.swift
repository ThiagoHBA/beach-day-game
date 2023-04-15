//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import SwiftUI

struct FindItemView: View {
//    @EnvironmentObject private var router: Router
    @ObservedObject private var controller = FindItemViewController()
    @State private var disableItem = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("room")
                    .resizable()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
                
                AvatarView(
                    items: $controller.findableItems,
                    protectionProgress: $controller.progress,
                    itemHasDropped: controller.showItemInteraction,
                    wrongSpotDropped: controller.wrongSpotItemDropped
                ).frame(
                    width: geo.size.width * 0.15,
                    height: geo.size.height * 0.7
                ).position(
                    x: geo.size.width * 0.5,
                    y: geo.size.height * 0.55
                )
                
                ForEach(controller.findableItems) { item in
                    FindableItem(item: item, highlited: $controller.highlightItems)
                        .opacity(item.visible ? 1 : 0.001)
                        .onDrag {
                            return .init(contentsOf: URL(string: item.id.uuidString))!
                        }
                        .position(
                            item.roomPosition.getPosition(on: geo.frame(in: .global))
                        )
                    .disabled(disableItem || !item.visible)
                }
                
                ForEach(controller.dummyItems) { item in
                    FindableItem(item: item, highlited: $controller.highlightItems)
                        .position(item.roomPosition.getPosition(on: geo.frame(in: .global)))
                        .offset(x: item.isDragging ? 10 : 0)
                        .animation(Animation.default.repeatCount(5).speed(6), value: item.isDragging)
                        .onLongPressGesture {
                            let impact = UIImpactFeedbackGenerator(style: .heavy)
                            let index = controller.dummyItems.firstIndex { $0.id == item.id }
                            if let index {
                                impact.impactOccurred()
                                controller.showItemInteraction(controller.dummyItems[index])
                                withAnimation {
                                    controller.dummyItems[index].isDragging.toggle()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    controller.dummyItems[index].isDragging.toggle()
                                }
                            }
                        }
                        .disabled(disableItem)
                }
                
                VStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Protection Progress")
                                .font(Font.system(.caption))
                                .foregroundColor(.white)
                                .bold()
                                .padding([.leading], 8)
                            ProgressBar(progress: $controller.progress)
                                .frame(
                                    width: geo.size.width * 0.25,
                                    height: 32
                                )
                        }
                    }
                    Spacer()
                }.padding(54)
                
                SpeakBalloon(
                    interaction: controller.currentInteraction,
                    interactionOver: controller.updateInteractionIndex,
                    showing: controller.ballonIsShowing
                )
            }
        }
        .onChange(of: controller.ballonIsShowing, perform: { value in
            disableItem = value
        })
        .onAppear {
//            controller.didEndInteractions = router.nextInteraction
            controller.showInteraction()
        }
        .edgesIgnoringSafeArea(.all)
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
