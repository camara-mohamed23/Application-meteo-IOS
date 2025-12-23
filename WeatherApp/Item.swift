//
//  Item.swift
//  WeatherApp
//
//  Created by MOUHAMED  CAMARA on 23/12/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
