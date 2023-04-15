//
//  SwiftUIView.swift
//  
//
//  Created by Thiago Henrique on 15/04/23.
//

import SwiftUI

struct DragPreviewImage: View {
    var image: String
    var onDropArea: Bool
    
    var body: some View {
        ZStack {
            Image(image)
            if onDropArea {
                Image(systemName: "checkmark.bubble.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.green)
                
            }
        }

    }
}

