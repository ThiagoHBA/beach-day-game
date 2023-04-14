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
    
    var screenOffSet : CGFloat {
        switch self {
        case.center:
            return UIScreen.main.bounds.height * 0
        case .top:
            return -UIScreen.main.bounds.height * 0.3
        case .bottom:
            return UIScreen.main.bounds.height * 0.3
        }
    }
}
