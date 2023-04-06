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
    var roomPosition: RoomPosition
    let accessoryPosition: AccessoryPosition
}

enum ItemType {
    case hat
    case sunglass
    case uvShirt
    case guitar
    case shoes
    
    var getRelativeFrame: CGSize {
        switch self {
            case .hat:
                return CGSize(width: 50, height: 50)
            case .sunglass:
                return CGSize(width: 80, height: 50)
            case .uvShirt:
                return CGSize(width: 100, height: 300)
            case .guitar:
                return CGSize(width: 100, height: 150)
            case .shoes:
                return CGSize(width: 100, height: 100)
        }
    }
}

extension RoomItem {
    static func generateFindableItems() -> [RoomItem] {
        return [
            RoomItem(
                type: .hat,
                image: "photo.fill",
                roomPosition: .wallShelf,
                accessoryPosition: .head
            ),
            RoomItem(
                type: .sunglass,
                image: "photo.fill",
                roomPosition: .bench,
                accessoryPosition: .eyes
            ),
            RoomItem(
                type: .uvShirt,
                image: "photo.fill",
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
                roomPosition: .bed,
                accessoryPosition: .none
            ),
            RoomItem(
                type: .shoes,
                image: "car.2.fill",
                roomPosition: .floor,
                accessoryPosition: .none
            )
        ]
    }
}
