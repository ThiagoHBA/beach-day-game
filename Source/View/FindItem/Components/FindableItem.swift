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
    var roomFrame: CGRect
    
    var body: some View {
        Image(item.image)
            .resizable()
            .frame(
                maxWidth: item.type.getRelativeFrame(parent: roomFrame).width,
                maxHeight: item.type.getRelativeFrame(parent: roomFrame).height
            )
    }
}

