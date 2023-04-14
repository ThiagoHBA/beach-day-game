//
//  File.swift
//  
//
//  Created by Thiago Henrique on 07/04/23.
//

import Foundation

enum InteractionType {
    case speak
    case information
}

struct InteractionText {
    let text : String
    let screenPosition: ScreenPosition?
    let type: InteractionType
    let minimumDuration: Int?
    let action: (() -> Void)?
    
    init(text: String, screenPosition: ScreenPosition?, type: InteractionType, minimumDuration: Int?, action: (() -> Void)? = nil) {
        self.text = text
        self.screenPosition = screenPosition
        self.type = type
        self.minimumDuration = minimumDuration
        self.action = action
    }
}
