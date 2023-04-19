//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation

struct RoomItem: Identifiable, Hashable {
    let id: UUID = UUID()
    var visible: Bool = true
    var isDragging: Bool = false
    var onDropArea: Bool = false
    let type: ItemType
    let image: String
    let accessoryImage: String
    var roomPosition: RoomPosition
    let accessoryPosition: AccessoryPosition
    var absolutePosition: Location?
    var effect: InteractionEffect
}

extension RoomItem {
    static func generateFindableItems() -> [RoomItem] {
        return [
            RoomItem(
                type: .hat,
                image: "hat_undrawed",
                accessoryImage: "",
                roomPosition: .keyboard,
                accessoryPosition: .head,
                effect: .itemDropped
            ),
            RoomItem(
                type: .sunglass,
                image: "sunglass_undrawed",
                accessoryImage: "sunglass_drawed",
                roomPosition: .bedsideTable,
                accessoryPosition: .eyes,
                effect: .itemDropped
            ),
            RoomItem(
                type: .uvShirt,
                image: "uvshirt_undrawed",
                accessoryImage: "uvshirt_drawed",
                roomPosition: .wardrobe,
                accessoryPosition: .body,
                effect: .itemDropped
            )
        ]
    }
    
    static func generateDummyItems() -> [RoomItem] {
        return [
            RoomItem(
                type: .guitar,
                image: "guitar",
                accessoryImage: "guitar",
                roomPosition: .wall,
                accessoryPosition: .none,
                effect: .wrongItemDropped
            ),
            RoomItem(
                type: .shoes,
                image: "shoes_undrawed",
                accessoryImage: "shoes_undrawed",
                roomPosition: .floor,
                accessoryPosition: .none,
                effect: .wrongItemDropped
            )
        ]
    }
}
