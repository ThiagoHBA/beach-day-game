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

enum InteractionEffect {
    case wrongItemDropped
    case itemDropped
    case wrongSpotDropped
    
    var associetedImage: String {
        switch self {
            case .wrongItemDropped:
                return "kid_thinking"
            case .itemDropped:
                return "kid_idle"
            case .wrongSpotDropped:
                return "kid_thinking"
        }
    }
}

struct InteractionText {
    let text : String
    let screenPosition: ScreenPosition?
    let type: InteractionType
    let effect: InteractionEffect?
    let minimumDuration: Int?
    let action: (() -> Void)?
    
    init(text: String,
         screenPosition: ScreenPosition?,
         type: InteractionType,
         effect: InteractionEffect? = nil,
         minimumDuration: Int?,
         action: (() -> Void)? = nil
    ) {
        self.text = text
        self.screenPosition = screenPosition
        self.type = type
        self.effect = effect
        self.minimumDuration = minimumDuration
        self.action = action
    }
}
