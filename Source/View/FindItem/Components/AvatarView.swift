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
    @State var removeHair = false
    var itemHasDropped: ((RoomItem) -> Void)?
    var wrongSpotDropped: (() -> Void)?
    
    var body: some View {
        ZStack {
            KidImage(removeHair: removeHair)
            GeometryReader { geo in
                ForEach(0..<accessories.count, id: \.self) { i in
                    FindableItem(item: accessories[i].item, accessory: true, highlited: .constant(false))
                        .opacity(accessories[i].item.visible ? 1 : 0.001)
                        .position(
                            accessories[i].item.accessoryPosition.getPositionCoordinate(
                                geo.frame(in: .global)
                            )
                        )
                        .onDrop(of: [.url], delegate: DropViewDelegate(
                            screen: self,
                            draggedItem: $draggedItem,
                            destinationItem: $accessories[i].item
                        ))
                    //                        .onDrop(of: [.url], isTargeted: .constant(false)) {
                    //                            providers in
                    //                            if let first = providers.first {
                    //                                let _ = first.loadObject(ofClass: URL.self) {
                          //                                    value, error in
                    //                                    guard let url = value else { return }
                    //                                    verifyItemDrop(with: url, on: accessory.position)
                    //                                }
                    //                            }
                    //                            return false
                    //                        }
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
        }
    }
    
    func calculateProgress() {
        withAnimation {
            protectionProgress = CGFloat(visibleItems) / CGFloat(items.count)
        }
    }
    
    func changeItemDrop(of item: RoomItem) {
        let itemIndex = items.firstIndex { $0.id == item.id }
        if let itemIndex { items[itemIndex].onDropArea.toggle() }
    }
    
    func performItemDrop(of item: RoomItem, on position: AccessoryPosition) -> Bool {
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
                    if position == .head { removeHair = true }
                }
                return true
            }
            return false
        }
        DispatchQueue.main.async { wrongSpotDropped?() }
        return false
    }
    
    func verifyItemDrop(with url: URL, on position: AccessoryPosition) -> Bool {
        for i in 0..<items.count {
            if items[i].id.uuidString == "\(url)" {
                if items[i].accessoryPosition == position {
                    guard let index = accessories.firstIndex(
                        where:{
                            $0.item.id == items[i].id
                        }
                    ) else { return false }
                    
                    DispatchQueue.main.async {
                        items[i].visible.toggle()
                        accessories[index].item.visible.toggle()
                        visibleItems += 1
                        calculateProgress()
                        itemHasDropped?(items[i])
                        if position == .head { removeHair = true }
                    }
                    return true
                }
                DispatchQueue.main.async {
                    wrongSpotDropped?()
                }
            }
        }
        return false
    }
}

struct DropViewDelegate: DropDelegate {
    var screen: AvatarView
    @Binding var draggedItem: RoomItem?
    @Binding var destinationItem: RoomItem
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func dropEntered(info: DropInfo) {
        if let draggedItem {
            if draggedItem.accessoryPosition == destinationItem.accessoryPosition {
                screen.changeItemDrop(of: draggedItem)
            }
        }
    }
    
    func dropExited(info: DropInfo) {
        if let draggedItem {
            if draggedItem.accessoryPosition == destinationItem.accessoryPosition {
                screen.changeItemDrop(of: draggedItem)
            }
        }
    }
    
    func performDrop(info: DropInfo) -> Bool {
        if let draggedItem {
            return screen.performItemDrop(of: draggedItem, on: destinationItem.accessoryPosition)
        }
        return false
    }
}
