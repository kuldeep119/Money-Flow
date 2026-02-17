//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by kuldeep Singh on 15/02/26.
//

import SwiftUI
import SwiftData

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Expense.self])
    }
}
