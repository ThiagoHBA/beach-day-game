//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation
import SwiftUI
import SpriteKit

struct FindableItem: View {
    var item: RoomItem
    var accessory: Bool = false
    var highlited: Bool = false
    var hightlighAlways: Bool = false
    
    var body: some View {
        ZStack {
            Image(accessory ? item.accessoryImage : item.image)
                .resizable()
                .scaledToFill()
                .frame(
                    maxWidth:  item.type.getRelativeFrame.width,
                    maxHeight: item.type.getRelativeFrame.height
                )
                .scaleEffect(highlited ? 1.5 : 1)
                .scaleEffect(hightlighAlways ? 1.1 : 1)
                .scaleEffect(accessory ? 1 : 0.4)
                .animation(Animation.default.repeatCount(5).speed(2), value: highlited)
                .animation(Animation.default.repeatForever().speed(1), value: hightlighAlways)
            SpriteView(
                scene: FindableItemScene(),
                options: [.allowsTransparency]
            )
            .frame(width: item.type.getRelativeFrame.width, height: item.type.getRelativeFrame.height)
        }
    }
}

class FindableItemScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        let rect = SKShapeNode(rect: view.bounds)
        rect.physicsBody = SKPhysicsBody(rectangleOf: view.bounds.size)
        rect.physicsBody?.contactTestBitMask = 0b001
        physicsWorld.contactDelegate = self
    }
}

extension FindableItemScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        print("Contact!!")
    }
}

