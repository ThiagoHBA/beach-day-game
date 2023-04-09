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
    @Published var interactionTexts: [InteractionText]!
    @Published var currentInteraction: InteractionText!
    @Published var highlightItems = false
    @Published private(set) var ballonIsShowing = false
    private var currentIndex = 0
    
    init() {
        generateInitialTexts()
        updateCurrentInteraction()
    }

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
    
    private func generateInitialTexts() {
        interactionTexts = [
            InteractionText(
                text: "Today is finally beach day! I need to prepare as quickly as possible without forgetting anything!",
                screenPosition: .center,
                minimumDuration: 4
            ),
            InteractionText(
                text: "I have several items in my room",
                screenPosition: .center,
                minimumDuration: 1,
                action: { [weak self] in
                    self?.highlightItems.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self?.highlightItems.toggle()
                    }
                }
            ),
            InteractionText(
                text: "I have several items in my room",
                screenPosition: .center,
                minimumDuration: 1
            ),
            InteractionText(
                text: "I need to find out which ones will help me enjoy the beach safely",
                screenPosition: .center,
                minimumDuration: 3
            ),
            InteractionText(
                text: "Alright, let's get started, what do I need to bring?",
                screenPosition: .center,
                minimumDuration: 2
            )
        ]
    }
    
}
