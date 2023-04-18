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
                    "Skin cancer is highly prevalent in countries like the United States 🇺🇸 and Brazil 🇧🇷, with **one in five Americans** developing skin cancer during their lifetime.",
                    "Sunburns in **childhood** and **adolescence** can increase the risk of developing melanoma in adulthood, according to the American Academy of Dermatology **(AAD)**  📃.",
//                    "Uncontrolled exposure to UV rays caused by solar radiation ☀️ is responsible for most melanomas.",
                    "But how can we **prevent** and protect ourselves? 🤔",
                    "Maybe we can learn this with little Ethan. Today he is going to the beach ⛱️ with his family and he needs to get ready to avoid sunburn!"
                ]
            )
        case .final:
            return CarouselTexts(
                texts: [
                    "Ethan enjoyed the beach safely and without **any** sunburn! 🎉",
                    "Skin cancer is something that should be treated very **seriously** and it affects many people **every day**.",
                    "Use what you learn here in your daily routine to properly protect yourself.",
                    "You can monitor your location's **UV indexes** through your **Weather** app on iPhone 📱",
                    "Stay safe and protect yourself, bye bye 👋🏼",
                ]
            )
        }
    }
}
