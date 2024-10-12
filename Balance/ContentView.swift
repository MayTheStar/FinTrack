//
//  ContentView.swift
//  Balance
//
//  Created by Diala Abdulnasser Fayoumi on 26/03/1446 AH.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ExpenseViewModel()

    @State private var selectedCategory: String? // Track the selected category
    @State private var amounts: [String: Double] = ["Food": 0.0, "Education": 0.0, "Transportation": 0.0, "Others": 0.0]
    @State private var spendings = ""
    @State private var showInput = false // State to control input visibility
    @State private var checkAmount: Double = 0.0 // Amount to input
    var goal: String

    private var totalBalance: Double {
        amounts.values.reduce(0, +) // Sum all amounts in the dictionary
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Top Card Section
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color.blue)
                            .frame(width: 360, height: 300)

                        VStack(alignment: .leading) {
                            HStack {
                                Text("Welcome 🎉!")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.top, 50)
                                    .padding(.leading, 20)
                                Spacer()
                            }

                            VStack(alignment: .leading) {
                                Text("Balance")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .padding(.leading, 20)

                                HStack {
                                    Text("\(totalBalance, specifier: "%.2f") SR /")
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("\(goal) SR")
                                        .font(.system(size: 40))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                .padding(.leading, 20)

                                Text("\(Calendar.current.dateComponents([.day], from: Date(), to: Calendar.current.date(byAdding: .month, value: 1, to: Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Date()))!)!.addingTimeInterval(-86400)).day ?? 0) days left")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .padding(.leading, 20)
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)

                    // Main Content Section
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Track Your Spending")
                                .font(.title2)
                                .bold()
                            Menu("History") {
                                ForEach(viewModel.expenses.keys.sorted(), id: \.self) { category in
                                    NavigationLink(destination: ExpenseHistoryView(viewModel: viewModel, category: category)) {
                                        Text(category)
                                    }
                                }
                            }
                        }

                        // Spending Categories List
                        SpendingCategoryView(category: "Food", description: "Restaurants, food, grocery ...", amount: Int(amounts["Food"] ?? 0.0), selectedCategory: $selectedCategory, showInput: $showInput)
                        SpendingCategoryView(category: "Education", description: "University supplements ...", amount: Int(amounts["Education"] ?? 0), selectedCategory: $selectedCategory, showInput: $showInput)
                        SpendingCategoryView(category: "Transportation", description: "Gas, driver, car monthly rent ...", amount: Int(amounts["Transportation"] ?? 0), selectedCategory: $selectedCategory, showInput: $showInput)
                        SpendingCategoryView(category: "Others", description: "Add other spendings ...", amount: Int(amounts["Others"] ?? 0), selectedCategory: $selectedCategory, showInput: $showInput)
                    }
                    .padding(.top)
                }

                // Overlay and Modal
                if showInput {
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                        .padding(.horizontal, 0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)

                    VStack {
                        Spacer() // Pushes the modal to the bottom of the screen

                        // Modal content at the bottom
                        VStack(spacing: 35) {
                            VStack {
                                // Circle icon matching the design
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 75, height: 75)
                                    .overlay(
                                        Image(systemName: categoryIcon(category: selectedCategory ?? "Others"))
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                            .padding(10)
                                    )
                                Text("Enter your spendings")
                                    .font(.system(size: 27))
                                    .fontWeight(.bold)
                                    .padding(.top, 40)
                            }

                            VStack {
                                TextField("Enter spendings", text: $spendings)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)

                                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "SR"))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                                    .keyboardType(.decimalPad)

                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                            Button("Done") {
                                                dismissKeyboard()
                                            }
                                        }
                                    }
                      
                            }

                            HStack(spacing: 40) {
                                Button("Cancel") {
                                    withAnimation {
                                        showInput = false // Hide the input fields
                                        selectedCategory = nil // Reset selected category
                                    }
                                }
                                .foregroundColor(.blue)
                                .frame(width: 100, height: 45)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))

                                Spacer()

                                Button("Update") {
                                    if let category = selectedCategory {
                                        amounts[category] = (amounts[category] ?? 0) + checkAmount // Update the amount for the selected category
                                        viewModel.addExpense(category: category, name: spendings, amount: checkAmount)
                                    }
                                    showInput = false // Hide the input fields after update
                                    selectedCategory = nil // Reset selected category
                                    checkAmount = 0 // Reset the input amount
                                    spendings = ""
                                }
                                .disabled(selectedCategory == nil || checkAmount <= 0)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 45)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.blue))
                            }
                        }
                        
                        .frame(height: 650)
                        .background(
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                Rectangle()
                                    .frame(height: 650 / 2)
                            }.foregroundColor(.white)
                        )
                        .padding(.bottom, -35)
                        .ignoresSafeArea()

                    }
                    .animation(.easeInOut) // Smooth animation
                }
            }

        }
            .navigationBarHidden(true)
        }
    }
    



    // Icon function for the selected category
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
//}

    
extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct SpendingCategoryView: View {
    var category: String
    var description: String
    var amount: Int
    @Binding var selectedCategory: String? // Binding to track selected category
    @Binding var showInput: Bool // Binding to control input visibility

    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: categoryIcon(category: category))
                        .foregroundColor(.white)
                )

            VStack(alignment: .leading) {
                Text(category)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text("\(amount) SR")
                .bold()
                .font(.headline)
                .foregroundColor(.black)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .padding(.horizontal)
        .onTapGesture {
            selectedCategory = category // Set selected category on tap
            showInput = true // Show the input fields
        }
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

#Preview {
    ContentView(goal: "1000") // Provide a sample goal for preview
}
