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
}

extension RoomItem {
    static func generateFindableItems() -> [RoomItem] {
        return [
            RoomItem(
                type: .hat,
                image: "hat_undrawed",
                accessoryImage: "hat_drawed",
                roomPosition: .keyboard,
                accessoryPosition: .head
            ),
            RoomItem(
                type: .sunglass,
                image: "sunglass_undrawed",
                accessoryImage: "sunglass_drawed",
                roomPosition: .bedsideTable,
                accessoryPosition: .eyes
            ),
            RoomItem(
                type: .uvShirt,
                image: "uvshirt_undrawed",
                accessoryImage: "uvshirt_undrawed",
                roomPosition: .wardrobe,
                accessoryPosition: .body
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
                accessoryPosition: .none
            ),
            RoomItem(
                type: .shoes,
                image: "shoes_undrawed",
                accessoryImage: "shoes_undrawed",
                roomPosition: .floor,
                accessoryPosition: .none
            )
        ]
    }
}
