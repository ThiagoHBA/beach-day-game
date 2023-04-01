//
//  File.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
//

import Foundation

class CarouselController: ObservableObject {
    @Published private(set) var carouselOrder: CarouselViewOrder = .first
    var didEndPages: (() -> Void)? = nil
   
    func nextPage() {
        if carouselOrder.rawValue < CarouselViewOrder.allCases.count - 1 {
            let currentValue = carouselOrder.rawValue
            carouselOrder = CarouselViewOrder(rawValue: currentValue + 1)!
            return
        }
        didEndPages?()
    }
}
