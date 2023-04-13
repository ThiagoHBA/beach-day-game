//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation

enum AccessoryPosition {
    case head
    case eyes
    case body
    case none
    
    func getPositionCoordinate(_ frame: CGRect) -> CGPoint {
        switch self {
            case .head:
                return CGPoint(
                    x: frame.size.width * 0.5,
                    y: frame.size.height * 0.08
                )
            case .eyes:
                return CGPoint(
                    x: frame.size.width * 0.5,
                    y: frame.size.height * 0.22
                )
            case .body:
               return CGPoint(
                    x: frame.size.width * 0.5,
                    y: frame.size.height * 0.56
                )
            case .none:
                return CGPoint(x: 0.0, y: 0.0)
            }
    }
}

extension AccessoryPosition {
    static let accesories: [AccessoryPosition] = [
        .head,
        .eyes,
        .body
    ]
}
