//
//  File.swift
//  
//
//  Created by Thiago Henrique on 06/04/23.
//

import Foundation

class SunscreenViewController: ObservableObject {
    let startInk = 500
    @Published private(set) var remainingInk: Int!
    @Published private(set) var points: [Point] = []
    @Published private(set) var pixelFilledStartArea: Set<Location> = []
    @Published private(set) var pixelFilledFinishArea: Set<Location> = []
    
    init() { self.remainingInk = startInk }
    
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
        remainingInk = points.count <= startInk ? startInk - points.count : 0
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
}
