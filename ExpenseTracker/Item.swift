//
//  Item.swift
//  ExpenseTracker
//
//  Created by kuldeep Singh on 15/02/26.
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
