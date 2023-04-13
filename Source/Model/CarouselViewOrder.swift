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
//    case second = 1
//    case third = 2
    
    var textContent: CarouselTexts {
        switch self {
//        case .first:
//            return CarouselTexts(
//                texts: [
//                    "The sun is the source of light that enables life on our planet.",
//                    "It is responsible for enabling photosynthesis in plants, generating different types of energy, the existence of seasons, among other responsibilities."
//                ]
//            )
//        case .second:
//            return CarouselTexts(
//                texts: [
//                    "But what about humans?",
//                    "Well, for humans, it is present in our lives in various ways, directly or indirectly influencing us.",
//                    "It is responsible for regulating our sleep cycle, body temperature, and especially for activating vitamin D, crucial for strengthening our bones.",
//                    "Direct exposure of at least 5 to 10 minutes is necessary for activation to occur in our bodies. However, we must be very careful!",
//                    "Uncontrolled exposure to the sun can lead to various illnesses, including skin cancer."
//                ]
//
//            )
//
        case .first:
            return CarouselTexts(
                texts: [
                    "In countries like the United States and Brazil, skin cancer is the cancer with the highest incidence. It is estimated that one in five Americans develop skin cancer during their lifetime.",
                "According to the AAD (American Academy of Dermatology), sunburns in childhood and adolescence can favor the development of melanomas in adulthood.",
                "Most melanomas are attributed to uncontrolled exposure to UV rays caused by solar radiation.",
                "But how can we prevent it?",
                "Maybe we can learn a little from <the child's name>."
                ]
                
            )
        }
    }
}
