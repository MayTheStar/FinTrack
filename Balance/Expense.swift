//
//  Expense.swift
//  Balance
//
//  Created by Ashwaq on 03/04/1446 AH.
//

import Foundation
struct Expense: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var date: Date
}
