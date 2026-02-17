//
//  SwiftUIView.swift
//  ExpenseTracker
//
//  Created by kuldeep Singh on 15/02/26.
//

import SwiftUI
import SwiftData

struct AddExpense: View {
    let currencies = Locale.commonISOCurrencyCodes
    @AppStorage("selectedCurrency") private var selectedCurrency: String = "INR"
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var Date: Date = .now
    @State private var value: Double = 0
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Expense Name", text: $name)
                DatePicker("Select Date", selection: $Date, displayedComponents: .date)
                HStack (spacing: 200){
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(currencies, id: \.self) { code in
                            Text(code).tag(code)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()

                        TextField("Value", value: $value, format: .currency(code: selectedCurrency))
                }
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("save") {
                        let expense = Expense(name: name, Date: Date, value: value)
                        context.insert(expense)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddExpense()
}
