//
//  Item.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
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
