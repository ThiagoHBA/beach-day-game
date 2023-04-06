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
                image: "photo.fill",
                accessoryImage: "photo.fill.on.rectangle.fill",
                roomPosition: .wallShelf,
                accessoryPosition: .head
            ),
            RoomItem(
                type: .sunglass,
                image: "photo.fill",
                accessoryImage: "photo.fill.on.rectangle.fill",
                roomPosition: .bench,
                accessoryPosition: .eyes
            ),
            RoomItem(
                type: .uvShirt,
                image: "photo.fill",
                accessoryImage: "photo.fill.on.rectangle.fill",
                roomPosition: .wardrobe,
                accessoryPosition: .body
            )
        ]
    }
    
    static func generateDummyItems() -> [RoomItem] {
        return [
            RoomItem(
                type: .guitar,
                image: "guitars.fill",
                accessoryImage: "photo.fill.on.rectangle.fill",
                roomPosition: .bed,
                accessoryPosition: .none
            ),
            RoomItem(
                type: .shoes,
                image: "car.2.fill",
                accessoryImage: "photo.fill.on.rectangle.fill",
                roomPosition: .floor,
                accessoryPosition: .none
            )
        ]
    }
}
