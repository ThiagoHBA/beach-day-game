//
//  File.swift
//  
//
//  Created by Thiago Henrique on 01/04/23.
//

import Foundation
import SwiftUI

struct FindableItem: View {
    var item: RoomItem
    var accessory: Bool = false
    @Binding var highlited: Bool
    
    var body: some View {
        Image(accessory ? item.accessoryImage : item.image)
            .resizable()
            .scaledToFill()
            .frame(
                maxWidth:  item.type.getRelativeFrame.width,
                maxHeight: item.type.getRelativeFrame.height
            )
            .scaleEffect(highlited ? 1.5 : 1)
            .scaleEffect(accessory ? 1 : 0.4)
            .animation(Animation.default.repeatCount(5).speed(2), value: highlited)
    }
}

