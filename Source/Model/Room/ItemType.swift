//
//  File.swift
//  
//
//  Created by Thiago Henrique on 06/04/23.
//

import Foundation

enum ItemType {
    case hat
    case sunglass
    case uvShirt
    case guitar
    case shoes
    
    var getRelativeFrame: CGSize {
        switch self {
            case .hat:
                return CGSize(width: 300, height: 150)
            case .sunglass:
                return CGSize(width: 220, height: 100)
            case .uvShirt:
                return CGSize(
                    width: 200, height: 250
                )
            case .guitar:
                return CGSize(width: 250, height: 250)
            case .shoes:
                return CGSize(width: 250, height: 250)
        }
    }
    
    var description: String {
        switch self {
            case .hat:
                return "That's it! The hat will help me prevent burns on my face and ears!"
            case .sunglass:
                return "Thank goodness I didn't forget my sunglasses! They can protect my eyes from the sun and make me look stylish."
            case .uvShirt:
                return "I received this shirt as a gift last summer! It will help reflect the sun that would otherwise directly hit my skin! What a gift!"
            case .guitar:
                return "It will be great to play guitar on the beach! But I don't think it will help me avoid getting sunburned."
            case .shoes:
                return "Although these shoes are stylish, I think flip-flops are more suitable for the beach."
        }
    }
}
