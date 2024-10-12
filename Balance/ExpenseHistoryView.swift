//
//  ExpenseHistoryView.swift
//  Balance
//
//  Created by Ashwaq on 03/04/1446 AH.
//

import SwiftUI

struct ExpenseHistoryView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    var category: String
    
    @State private var showingAddExpense = false
    @State private var newExpenseName: String = ""
    @State private var newExpenseAmount: String = ""

    var body: some View {
        
        ZStack {
            Color(.systemGray6).opacity(0.1)  // Gray background color for the entire view
                .ignoresSafeArea()  // Fill the entire screen
            
            VStack(alignment: .leading) {
                
                HStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 60, height: 60)  // Fixed size for the circle
                        .overlay(
                            Image(systemName: categoryIcon(category: category))
                                .font(.system(size: 30))  // Icon size
                                .foregroundColor(.white)  // Icon color
                        )
                    
                    Text("\(category) Expenses")
                        .font(.title)  // Change to title font
                        .fontWeight(.bold)
                }
                .padding()  // Padding around the title
                
                
                List {
                    ForEach(viewModel.expenses[category] ?? []) { expense in
                        HStack {
                            Text(expense.name).font(
                                .system(
                                    size: 20, weight: .semibold,
                                    design: .default))
                            Spacer()
                            Text("\(expense.amount, specifier: "%.2f")").font(.system(
                                size: 18, weight: .semibold,
                                design: .default))
                            Text("SR").font(
                                .system(
                                    size: 12, weight: .thin, design: .default))
                            
                        }.listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        
                            .padding()  // Add padding around the item
                            .frame(height: 80)  // Set a specific height for each item
                            .background(Color.white)  // Optional background color
                            .cornerRadius(8)  // Rounded corners
                            .overlay(  // Adding border
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 0.1)  // Border color and width
                            )
                            .shadow(
                                color: Color.gray.opacity(0.1), radius: 4, x: 2,
                                y: 2
                            )  // Shadow effect
                            .padding(.vertical, -5)  // Space between items
                        
                    }
                }
            }
        }
//        .navigationTitle("\(category) Expenses")
        .listStyle(PlainListStyle())
//
    }
    func categoryIcon(category: String) -> String {
        switch category {
        case "Food":
            return "fork.knife"
        case "Education":
            return "book.fill"
        case "Transportation":
            return "car.fill"
        case "Others":
            return "ellipsis.circle.fill"
        default:
            return "questionmark"
        }
    }
}

