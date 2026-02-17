//
//  UpdateExpense.swift
//  ExpenseTracker
//
//  Created by kuldeep Singh on 18/02/26.
//

import SwiftUI
import SwiftData

struct UpdateExpense: View {
    let currencies = Locale.commonISOCurrencyCodes
    @AppStorage("selectedCurrency") private var selectedCurrency: String = "INR"

    @Environment(\.dismiss) private var dismiss
    @Bindable var expense: Expense
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Expense Name", text: $expense.name)
                DatePicker("Select Date", selection: $expense.Date, displayedComponents: .date)
                HStack (spacing: 200){
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(currencies, id: \.self) { code in
                            Text(code).tag(code)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()

                    TextField("Value", value: $expense.value, format: .currency(code: selectedCurrency))
                }
            }
            .navigationTitle("Update Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview {
    // Sample example for Expense preview
    let sample = Expense(name: "Groceries", Date: .now, value: 132.45)
    UpdateExpense(expense: sample)
}
