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
    @State var accessories: [Accessory] = []
    
    var body: some View {
        ZStack {
            Capsule()
                .foregroundColor(.gray)
            GeometryReader { geo in
                ForEach(accessories, id: \.self) { accessory in
                    FindableItem(item: accessory.item)
                        .opacity(accessory.item.visible ? 1 : 0.001)
                        .border(.red)
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
                                    for i in 0..<items.count {
                                        if items[i].id.uuidString == "\(url)" &&
                                        items[i].accessoryPosition == accessory.position {
                                            guard let index = accessories.firstIndex(
                                                where:{
                                                    $0.item.id == items[i].id
                                                }
                                            ) else { return }
                                            
                                            items[i].visible.toggle()
                                            accessories[index].item.visible.toggle()
                                        }
                                    }
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
}
