//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import SwiftUI

class DragDelegate: NSObject, UIDragInteractionDelegate {
    var draggedItem: RoomItem
    
    init(draggedItem: RoomItem) {
        self.draggedItem = draggedItem
        super.init()
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        return [
            UIDragItem(
                itemProvider: .init(contentsOf: URL(string: draggedItem.id.uuidString))!
            )
        ]
    }
    
    
}

struct FindItemView: View {
    @EnvironmentObject private var router: Router
    @ObservedObject private var controller = FindItemViewController()
    @State private var disableItem = false
    @State private var draggedItem: RoomItem?
    @State private var tryToDropItem: ((RoomItem) -> Void)?
    
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
                    draggedItem: $draggedItem,
                    itemHasBeenReleased: $tryToDropItem,
                    itemHasDropped: { item in
                        controller.playDropSong(of: .successDrop)
                        controller.showItemInteraction(item)
                    },
                    wrongSpotDropped: {
                        controller.playDropSong(of: .wrongSpotDrop)
                        controller.wrongSpotItemDropped()
                    }
                ).frame(
                    width: geo.size.width * 0.15,
                    height: geo.size.height * 0.7
                ).position(
                    x: geo.size.width * 0.5,
                    y: geo.size.height * 0.55
                )
                
                ForEach($controller.findableItems) { $item in
                    FindableItem(
                        item: item,
                        highlited: controller.highlightItems,
                        hightlighAlways: controller.startUserInteraction
                    )
                    .opacity(item.visible ? 1 : 0.001)
                    .position(
                        item.absolutePosition?.toCGPoint() ??
                        item.roomPosition.getPosition(on: geo.frame(in: .global))
                    )
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ value in
                                item.absolutePosition = Location(value.location)
                                draggedItem = item
                            })
                            .onEnded({ _ in
                                tryToDropItem?(item)
                                item.absolutePosition = nil
//                                UIDragInteraction(delegate: DragDelegate(draggedItem: item))
                            })
                    )
                    .disabled(disableItem || !item.visible)
//                        .gesture(
//                            DragGesture()
//                                .onChanged({ value in
//                                    controller.findableItems[i].absolutePosition = Location(value.translation)
//                                })
//                            LongPressGesture(minimumDuration: 0.1)
//                                .sequenced(
//                                    before: DragGesture()
//                                    .onChanged({ value in
//                                        controller.findableItems[i].absolutePosition = Location(value.location)
//                                    })
//                                    .onEnded({ _ in
//                                        controller.findableItems[i].absolutePosition = nil
//                                    })
//                                )
//                        )
//                        .position(
//                            controller.findableItems[i].absolutePosition?.toCGPoint() ?? .zero
//                            controller.findableItems[i].roomPosition.getPosition(on: geo.frame(in: .global))
//                        )
//                        .offset(x: controller.findableItems[i].absolutePosition?.toCGPoint().x ?? 0.0, y: controller.findableItems[i].absolutePosition?.toCGPoint().y ?? 0.0
//                        )
                    
//                        .onDrag {
//                            draggedItem = item
//                            return .init(contentsOf: URL(string: item.id.uuidString))!
//                        } preview: {
//                            DragPreviewImage(
//                                image: item.image,
//                                onDropArea: item.onDropArea
//                            )
//                        }
                }
                
                ForEach(controller.dummyItems) { item in
                    FindableItem(
                        item: item,
                        highlited: controller.highlightItems,
                        hightlighAlways: controller.startUserInteraction
                    )
                        .position(item.roomPosition.getPosition(on: geo.frame(in: .global)))
                        .offset(x: item.isDragging ? 10 : 0)
                        .animation(Animation.default.repeatCount(5).speed(6), value: item.isDragging)
                        .onLongPressGesture(minimumDuration: 0) {
                            let index = controller.dummyItems.firstIndex { $0.id == item.id }
                            if let index {
                                controller.playDropSong(of: .failedDrop)
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
            controller.didEndInteractions = router.nextInteraction
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
