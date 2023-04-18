//
//  File.swift
//  
//
//  Created by Thiago Henrique on 31/03/23.
// 

import Foundation

class Router: ObservableObject {
    @Published private (set) var currentInteraction: Interaction = .sunscreen
    
    func nextInteraction() {
        if currentInteraction.rawValue < Interaction.allCases.count - 1 {
            let currentValue = currentInteraction.rawValue
            currentInteraction = Interaction(rawValue: currentValue + 1)!
            return
        }
        restart()
    }
    
    func restart() { currentInteraction = .play }
}
