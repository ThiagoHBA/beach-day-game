//
//  File.swift
//  
//
//  Created by Thiago Henrique on 06/04/23.
//

import Foundation

struct Point: Identifiable {
    let id = UUID()
    var location: CGPoint
    var opacity: Double = 1.0
}
