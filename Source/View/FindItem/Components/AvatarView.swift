//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation
import SwiftUI

struct AvatarView: View {
    @Binding var items: [RoomItem]
    @Binding var protectionProgress: CGFloat
    @State var accessories: [Accessory] = []
    @State var visibleItems = 0
    @State var removeHair = false
    var itemHasDropped: ((RoomItem) -> Void)?
    var wrongSpotDropped: (() -> Void)?
    
    var body: some View {
        ZStack {
            KidImage(removeHair: removeHair)
            GeometryReader { geo in
                ForEach(accessories, id: \.self) { accessory in
                    FindableItem(item: accessory.item, accessory: true, highlited: .constant(false))
                        .opacity(accessory.item.visible ? 1 : 0.001)
                        .position(
                            accessory.item.accessoryPosition.getPositionCoordinate(
                                geo.frame(in: .global)
                            )
                        )
                        .onDrop(of: [.url], isTargeted: .constant(false)) {
                            providers in
                            if let first = providers.first {
                                let _ = first.loadObject(ofClass: URL.self) {
                                    value, error in
                                    guard let url = value else { return }
                                    verifyItemDrop(with: url, on: accessory.position)
                                }
                            }
                            return false
                        }
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
    
    func verifyItemDrop(with url: URL, on position: AccessoryPosition) {
        for i in 0..<items.count {
            if items[i].id.uuidString == "\(url)" {
                if items[i].accessoryPosition == position {
                    guard let index = accessories.firstIndex(
                        where:{
                            $0.item.id == items[i].id
                        }
                    ) else { return }
                    
                    DispatchQueue.main.async {
                        items[i].visible.toggle()
                        accessories[index].item.visible.toggle()
                        visibleItems += 1
                        calculateProgress()
                        itemHasDropped?(items[i])
                        if position == .head { removeHair = true }
                    }
                    return
                }
                DispatchQueue.main.async {
                    wrongSpotDropped?()
                }
            }
        }
    }
}
