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
    let type: ItemType
    let image: String
    var roomPosition: RoomPosition
    let accessoryPosition: AccessoryPosition
}

enum ItemType {
    case hat
    case sunglass
    case uvShirt
    
    var getRelativeFrame: CGSize {
        switch self {
            case .hat:
                return CGSize(width: 50, height: 50)
            case .sunglass:
                return CGSize(width: 80, height: 50)
            case .uvShirt:
                return CGSize(width: 100, height: 300)
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
}
