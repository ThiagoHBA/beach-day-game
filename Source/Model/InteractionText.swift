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
}

extension InteractionText {
    static let avatarViewTexts = [
        InteractionText(
            text: "Today is finally beach day! I need to prepare as quickly as possible without forgetting anything!",
            screenPosition: .bottom,
            minimumDuration: 4
        ),
        InteractionText(
            text: "Alright, let's get started, what do I need to bring?",
            screenPosition: .top,
            minimumDuration: 4
        )
    ]
}
