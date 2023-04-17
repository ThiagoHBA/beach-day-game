//
//  File.swift
//  
//
//  Created by Thiago Henrique on 06/04/23.
//

import Foundation

class SunscreenViewController: ObservableObject {
    let startInk = 5.0
    @Published private(set) var remainingInk: CGFloat!
    @Published private(set) var points: [Point] = []
    @Published private(set) var pixelFilledStartArea: Set<Location> = []
    @Published private(set) var pixelFilledFinishArea: Set<Location> = []
    @Published var interactionTexts: [InteractionText]!
    @Published var currentInteraction: InteractionText!
    private var currentIndex = 0
    @Published private(set) var ballonIsShowing = false
    var didEndInteractions: (() -> Void)?
    
    init() {
        self.remainingInk = startInk
        generateInitialTexts()
        updateCurrentInteraction()
    }
    
    func restartValues() {
        remainingInk = startInk
        points.removeAll()
        pixelFilledFinishArea.removeAll()
    }
    
    func updateFilledStartArea(with value: Set<Location>) {
        self.pixelFilledStartArea = value
    }
    
    func updateFilledfinishArea(with value: Set<Location>) {
        self.pixelFilledFinishArea = value
    }
    
    func calculatePercentOfTotalFilledArea() -> Int {
        if pixelFilledStartArea.isEmpty { return 0 }
        let filledArea = pixelFilledStartArea.count - pixelFilledFinishArea.count
        return (filledArea * 100) / pixelFilledStartArea.count
    }
    
    func calculateRemainingInk() {
        remainingInk = CGFloat(points.count)/100 <= startInk ? startInk - CGFloat(points.count)/100: 0
    }
    
    func decreasePointsOpacity() {
        for pointIndex in points.indices {
            if points[pointIndex].opacity >= 0.1 {
                points[pointIndex].opacity -= 0.05
            }
        }
    }
    
    func appendNewPoint(_ point: Point) {
        points.append(point)
    }
    
    func didDrag(on location: Location, finishInk: (() -> Void)? = nil) {
        if remainingInk > 0 {
            appendPointToFace(location: location)
            return
        }
        finishInk?()
    }
    
    func appendPointToFace(location: Location) {
        if pixelFilledStartArea.contains(location)  {
            appendNewPoint(Point(location: CGPoint(x: location.x, y: location.y)))
            calculateRemainingInk()
        }
    }
    
    func showInteraction() { ballonIsShowing = true }
    
    func updateCurrentInteraction() {
        if interactionTexts.indices.contains(currentIndex) {
            currentInteraction = interactionTexts[currentIndex]
            return
        }
        currentInteraction = InteractionText(
            text: "",
            screenPosition: .top,
            type: .information,
            minimumDuration: 0
        )
    }
    
    func updateInteractionIndex() {
        if currentIndex < interactionTexts.count - 1 {
            currentIndex += 1
            updateCurrentInteraction()
            showInteraction()
            return
        }
        ballonIsShowing = false
    }
    
}

extension SunscreenViewController {
    private func generateInitialTexts() {
        interactionTexts = [
            InteractionText(
                text: "Now, last but not least, it's time for sunscreen!",
                screenPosition: .center,
                type: .speak,
                minimumDuration: 5
            ),
            InteractionText(
                text: "Alright! I'm running low on sunscreen, I need to be careful with the amount. My school teacher said the ideal amount for the face and neck was about a teaspoon of sunscreen.",
                screenPosition:.center,
                type: .speak,
                minimumDuration: 5
            ),
            InteractionText(
                text: "try to cover Ethan's face and neck using sunscreen with the limited amount of a teaspoon (5.0 ml)",
                screenPosition: .top,
                type: .information,
                minimumDuration: 5
            )
        ]
    }
}
