//
//  File.swift
//  
//
//  Created by Thiago Henrique on 17/04/23.
//

import Foundation

extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
