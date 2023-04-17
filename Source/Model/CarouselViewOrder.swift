//
//  File.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import Foundation

struct CarouselTexts {
    let texts: [String]
}

enum CarouselViewOrder: Int, CaseIterable {
    case first = 0
    case final = 1
    
    var textContent: CarouselTexts {
        switch self {
        case .first:
            return CarouselTexts(
                texts: [
                    "In countries like the United States 🇺🇸 and Brazil 🇧🇷, skin cancer is the cancer with the **highest** incidence.",
                    "It is estimated that one in five Americans develop skin cancer during their lifetime. sunburns in childhood and adolescence can favor the development of melanomas in adulthood.\n📃 Source: **AAD** (American Academy of Dermatology)",
                    "Most melanomas are attributed to uncontrolled **exposure** to UV rays caused by solar radiation. ☀️",
                    "But how can we prevent it? 🤔",
                    "Maybe we can learn from little Ethan. Today he is going to the beach ⛱️ with his family and he needs to get ready to avoid sunburn!"
                ]
            )
        case .final:
            return CarouselTexts(
                texts: [
                    "Ethan enjoyed the beach safely and without **any** sunburn!",
                    "Skin cancer is something that should be treated very **seriously** and it affects many people **every day**.",
                    "Use what you learn here in your daily routine to properly protect yourself. ",
                    "You can monitor your location's **UV indexes** through your **Weather** app on iPhone 📱",
                    "Stay safe and protect yourself, bye bye 👋🏼",
                ]
            )
        }
    }
}
