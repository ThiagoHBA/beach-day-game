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
    
    var body: some View {
        Image(systemName: item.image)
            .resizable()
            .frame(
                maxWidth: item.type.getRelativeFrame.width,
                maxHeight: item.type.getRelativeFrame.height
            )
    }
}

