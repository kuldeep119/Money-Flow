//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by kuldeep Singh on 15/02/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @State private var isShowing = false
    
    @Query(sort: \Expense.Date) var expenses: [Expense]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(expenses) { expense in
                    ExpenseCell(expense: expense)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Expenses")
            .toolbar {
                if !expenses.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button {
                            isShowing = true
                        } label: {
                            Label("Add Expense", systemImage: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowing) {
                AddExpense()
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                    } description: {
                        Text("Start adding expenses to see your expense list.")
                    } actions: {
                        Button("Add Expense") {
                            isShowing = true
                        }
                    }
                    .offset(y: -60)
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func delete(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(expenses[index])
            }
            
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Expense.self, inMemory: true)
}

struct ExpenseCell : View {
    let expense:Expense
    @AppStorage("selectedCurrency") private var selectedCurrency: String = "INR"
    var body: some View {
        HStack{
            Text(expense.Date, format: .dateTime.month(.abbreviated))
                .frame(width: 70,alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: selectedCurrency))
        }
    }
}
