//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation
import SwiftUI
import AVFoundation

struct AvatarView: View {
    @Binding var items: [RoomItem]
    @Binding var protectionProgress: CGFloat
    @Binding var draggedItem: RoomItem?
    @State var accessories: [Accessory] = []
    @State var visibleItems = 0
    @State var usingHat = false
    @Binding var itemHasBeenReleased: ((RoomItem) -> Void)?
    var itemHasDropped: ((RoomItem) -> Void)?
    var wrongSpotDropped: (() -> Void)?
    
    var body: some View {
        ZStack {
            KidImage(usingHat: usingHat)
            GeometryReader { geo in
                ForEach(0..<accessories.count, id: \.self) { i in
                    FindableItem(item: accessories[i].item, accessory: true)
                        .opacity(accessories[i].item.visible ? 1 : 0.001)
                        .overlay {
                            GeometryReader { proxy in
                                Color.clear.onAppear {
                                    accessories[i].item.absolutePosition = Location (
                                        proxy.frame(in: .global).origin
                                    )
                                }
                            }
                        }
                        .position(
                            accessories[i].item.accessoryPosition.getPositionCoordinate(
                                geo.frame(in: .global)
                            )
                        )
                }
            }
        }.onAppear {
            items.forEach { item in
                var accessory = Accessory(
                    item: item,
                    position: item.accessoryPosition
                )
                accessory.item.visible = false
                accessories.append(accessory)
            }
            
            itemHasBeenReleased = verifyItemDrop
        }
    }
    
    func calculateProgress() {
        withAnimation {
            protectionProgress = CGFloat(visibleItems) / CGFloat(items.count)
        }
    }
    
    func verifyItemDrop(_ item: RoomItem) {
        if let itemIndex = items.firstIndex(where: { $0.id == item.id }) {
            let currentItem = items[itemIndex]
            for accessory in accessories {
                let accessoryRect = CGRect(
                    x: accessory.item.absolutePosition!.x,
                    y: accessory.item.absolutePosition!.y,
                    width: Int(accessory.item.type.getRelativeFrame.width),
                    height: Int(accessory.item.type.getRelativeFrame.height)
                )
                
                if accessoryRect.contains (
                    CGPoint(
                        x: currentItem.absolutePosition!.x,
                        y: currentItem.absolutePosition!.y
                    )
                ) {
                    if performItemDrop(of: currentItem, on: accessory.position) { return }
                }
            }
        }
        
        func performItemDrop(of item: RoomItem, on position: AccessoryPosition) -> Bool {
            print("item: \(item.type)", "pos: \(position)")
            if item.accessoryPosition == position {
                let itemIndex = items.firstIndex { $0.id == item.id }
                let accessoryIndex = accessories.firstIndex { $0.item.id == item.id }
                if let itemIndex, let accessoryIndex {
                    DispatchQueue.main.async {
                        items[itemIndex].visible.toggle()
                        accessories[accessoryIndex].item.visible.toggle()
                        visibleItems += 1
                        calculateProgress()
                        itemHasDropped?(items[itemIndex])
                        if position == .head { usingHat = true }
                    }
                    return true
                }
                return false
            }
            DispatchQueue.main.async { wrongSpotDropped?() }
            return false
        }
    }
}
