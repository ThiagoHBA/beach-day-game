//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation

struct RoomItem {
    let type: ItemType
    let image: String
}

enum ItemType {
    case hat
    case sunglass
    case uvShirt
    
    func getRelativeFrame(parent: CGRect) -> CGSize {
        switch self {
            case .hat:
                return CGSize(
                    width: parent.size.width * 0.05,
                    height: parent.size.width * 0.035
                )
            case .sunglass:
                return CGSize(
                    width: parent.size.width * 0.05,
                    height: parent.size.width * 0.035
                )
            case .uvShirt:
                return CGSize(
                    width: parent.size.width * 0.1,
                    height:parent.size.width * 0.2
                )
        }
    }
}
