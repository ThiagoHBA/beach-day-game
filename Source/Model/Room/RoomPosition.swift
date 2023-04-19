//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation

enum RoomPosition {
    case wallShelf
    case keyboard
    case wall
    case wardrobe
    case bedsideTable
    case floor
    
    func getPosition(on parent: CGRect) -> CGPoint {
        switch self {
            case .wallShelf:
                return CGPoint(
                    x: parent.size.width * 0.16,
                    y: parent.size.height * 0.11
                )
            case .keyboard:
                return CGPoint(
                    x: parent.size.width * 0.35,
                    y: parent.size.height * 0.4897
                )
            case .wardrobe:
                return CGPoint(
                    x: parent.size.width * 0.14,
                    y: parent.size.height * 0.315
                )
            case .bedsideTable:
                return CGPoint(
                    x: parent.size.width * 0.966,
                    y: parent.size.height * 0.59
                )
            case .floor:
                return CGPoint(
                    x: parent.size.width * 0.8,
                    y: parent.size.height * 0.8
                )
            case .wall:
                return CGPoint(
                    x: parent.size.width * 0.347,
                    y: parent.size.height * 0.3
                )
        }
    }
}
