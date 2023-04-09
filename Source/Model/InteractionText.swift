//
//  File.swift
//  
//
//  Created by Thiago Henrique on 07/04/23.
//

import Foundation

struct InteractionText {
    let text : String
    let screenPosition: ScreenPosition?
    let minimumDuration: Int?
    let action: (() -> Void)?
    
    init(text: String, screenPosition: ScreenPosition?, minimumDuration: Int?, action: (() -> Void)? = nil ) {
        self.text = text
        self.screenPosition = screenPosition
        self.minimumDuration = minimumDuration
        self.action = action
    }
}
