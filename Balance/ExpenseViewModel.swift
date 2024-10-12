//
//  ExpenseViewModel.swift
//  Balance
//
//  Created by Ashwaq on 03/04/1446 AH.
//

import Foundation
import Foundation
import Combine

class ExpenseViewModel: ObservableObject {

    @Published var expenses: [String: [Expense]] = [
        "Food": [
//            Expense(name: "Groceries", amount: 50.00, date: Date()),
//            Expense(name: "Dining Out", amount: 30.00, date: Date())
        ],
        "Transportation": [
//            Expense(name: "Bus Ticket", amount: 2.50, date: Date())
        ],
        "Education": [],
        "Others": [
//            Expense(name: "Subscription", amount: 10.00, date: Date())
        ]
    ]
    
    func addExpense(category: String, name: String, amount: Double) {
        print("hi1")
        let newExpense = Expense(name: name, amount: amount, date: Date())
        print("hi2")
        expenses[category]?.append(newExpense)
        print("hi3")
    }
}
