//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation

enum RoomPosition {
    case wallShelf
    case bench
    case wardrobe
    
    func getPosition(on parent: CGRect) -> CGPoint {
        switch self {
            case .wallShelf:
                return CGPoint(
                    x: parent.size.width * 0.16,
                    y: parent.size.height * 0.11
                )
            case .bench:
                return CGPoint(
                    x: parent.size.width * 0.30,
                    y: parent.size.height * 0.57
                )
            case .wardrobe:
                return CGPoint(
                    x: parent.size.width * 0.93,
                    y: parent.size.height * 0.49
                )
        }
    }
}
