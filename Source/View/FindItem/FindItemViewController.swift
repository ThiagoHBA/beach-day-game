//
//  File.swift
//  
//
//  Created by Thiago Henrique on 08/04/23.
//

import Foundation

class FindItemViewController: ObservableObject {
    @Published var findableItems = RoomItem.generateFindableItems()
    @Published var dummyItems = RoomItem.generateDummyItems()
    @Published var interactionTexts = InteractionText.avatarViewTexts
    @Published var currentInteraction: InteractionText!
    @Published private(set) var ballonIsShowing = false
    private var currentIndex = 0
    
    init() { updateCurrentInteraction() }

    func showItemInteraction(_ item: RoomItem) {
        interactionTexts = [
            InteractionText (
                text: item.type.description,
                screenPosition: .bottom,
                minimumDuration: 4
            )
        ]
        currentIndex = 0
        updateCurrentInteraction()
        showInteraction()
    }
    
    func showInteraction() { ballonIsShowing = true }
    
    func updateInteractionIndex() {
        if currentIndex < interactionTexts.count - 1 {
            currentIndex += 1
            updateCurrentInteraction()
            showInteraction()
            return
        }
        ballonIsShowing = false
    }
    
    func updateCurrentInteraction() {
        if interactionTexts.indices.contains(currentIndex) {
            currentInteraction = interactionTexts[currentIndex]
            return
        }
        currentInteraction = InteractionText(text: "", screenPosition: .top, minimumDuration: 0)
    }
    
}
