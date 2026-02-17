//
//  Item.swift
//  ExpenseTracker
//
//  Created by kuldeep Singh on 15/02/26.
//

import Foundation
import SwiftData

@Model
class Expense {
    @Attribute(.unique) var name: String
    var Date : Date
    var value: Double
    
    init(name: String, Date: Date, value: Double) {
        self.name = name
        self.Date = Date
        self.value = value
    }
}
