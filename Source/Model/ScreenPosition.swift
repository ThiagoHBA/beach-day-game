//
//  File.swift
//  
//
//  Created by Thiago Henrique on 07/04/23.
//

import Foundation
import SwiftUI

enum ScreenPosition {
    case top
    case center
    case bottom
    
    func screenOffSet(size: CGSize) -> CGFloat {
        switch self {
        case.center:
            return size.height * 0
        case .top:
            return -size.height * 0.3
        case .bottom:
            return size.height * 0.3
        }
    }
}
