//
//  Untitled.swift
//  Balance
//
//  Created by Diala Abdulnasser Fayoumi on 30/03/1446 AH.
//

import SwiftUI

struct spendings: View {
    @State private var checkAmount = 0
    @State private var spendings = ""
    //get the catgory id or name 
    
    var body: some View {
        VStack {
            Image(systemName: "fork.knife.circle.fill")
                .resizable()
                .frame(width: 75, height: 75)
                .foregroundColor(Color(red: 0/255, green: 122/255, blue: 255/255))
            
            Text("Enter your spendings")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 20) {
                TextField("Enter spendings", text: $spendings)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? ""))
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            
            HStack(spacing: 120) {
                Button("Cancel") {
                    // Handle cancel action
                }
                .foregroundColor(.blue)
                .frame(width: 118, height: 45)
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
                
                Button("Update") {
                    // Handle update logic
                    // Take amount and set to specific itme which linked to catgories
                    //update
                   // $checkAmount
                    
                    
                    
                    
                }
                .foregroundColor(.white)
                .frame(width: 118, height: 45)
                .background(RoundedRectangle(cornerRadius: 8).fill(.blue))
            }
            .padding(.top)
        }
        .padding()
        .navigationTitle("Spendings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    spendings() // Preview for SpendingsView
}
