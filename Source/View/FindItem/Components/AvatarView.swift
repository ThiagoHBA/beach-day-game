//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation
import SwiftUI
import SpriteKit

class Avatar: SKScene {
    override func didMove(to view: SKView) {
        let kidIdleAtlas = SKTextureAtlas(named: "kid_idle")
        let node = SKSpriteNode(texture: kidIdleAtlas.textureNamed("kid_idle01"))
        node.zPosition = 1
        node.anchorPoint = CGPoint.zero
//        node.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        addChild(node)
        
//        node.run(
//            SKAction.repeatForever(
//                SKAction.animate(
//                    with: kidIdleAtlas.textureNames.map(SKTexture.init(imageNamed:)),
//                    timePerFrame: 0.5,
//                    resize: false,
//                    restore: true
//                )
//            )
//        )
        
    }
}

struct AvatarView: View {
    @Binding var items: [RoomItem]
    @Binding var protectionProgress: CGFloat
    @State var accessories: [Accessory] = []
    @State var visibleItems = 0
    var itemHasDropped: ((RoomItem) -> Void)?
    var wrongSpotDropped: (() -> Void)?
    
    var scene: SKScene {
        let scene = Avatar()
        scene.size = CGSize(width: 312, height: 710)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        return scene
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene, options: [.allowsTransparency])
                .frame(width: 312, height: 710)
                .background(.clear)
            GeometryReader { geo in
                ForEach(accessories, id: \.self) { accessory in
                    FindableItem(item: accessory.item, accessory: true, highlited: .constant(false))
                        .opacity(accessory.item.visible ? 1 : 0.001)
                        .border(.red)
                        .position(
                            accessory.item.accessoryPosition.getPositionCoordinate(
                                geo.frame(in: .global)
                            )
                        )
                        .onDrop(of: [.url], isTargeted: .constant(false)) {
                            providers in
                            if let first = providers.first {
                                let _ = first.loadObject(ofClass: URL.self) {
                                    value, error in
                                    guard let url = value else { return }
                                    verifyItemDrop(with: url, on: accessory.position)
                                }
                            }
                            return false
                        }
                }
            }
        }.onAppear {
            items.forEach { item in
                var accessory = Accessory(
                    item: item,
                    position: item.accessoryPosition
                )
                accessory.item.visible = false
                accessories.append(accessory)
            }
        }
    }
    
    func calculateProgress() {
        withAnimation {
            protectionProgress = CGFloat(visibleItems) / CGFloat(items.count)
        }
    }
    
    func verifyItemDrop(with url: URL, on position: AccessoryPosition) {
        for i in 0..<items.count {
            if items[i].id.uuidString == "\(url)" {
                if items[i].accessoryPosition == position {
                    guard let index = accessories.firstIndex(
                        where:{
                            $0.item.id == items[i].id
                        }
                    ) else { return }
                    
                    DispatchQueue.main.async {
                        items[i].visible.toggle()
                        accessories[index].item.visible.toggle()
                        visibleItems += 1
                        calculateProgress()
                        itemHasDropped?(items[i])
                    }
                    return
                }
                wrongSpotDropped?()
            }
        }
    }
}
