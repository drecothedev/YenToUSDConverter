//
//  ConvertedAmtTextBox.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/6/25.
//

import SwiftUI

// The amount that is sending out to be converted to USD
struct ConvertedAmtTextBox: View {
    @Binding var amtConverted: Double
    @Binding var usdAmt: Double
    @Binding var isDoneConverting: Bool
    @Binding var showResetButton: Bool
    @FocusState private var isFocused: Bool
    
    var convertedType: String
    var body: some View {
        TextField("Enter Amount :)", value: $amtConverted, format: .number) 
            .foregroundStyle(Color.white)
            .keyboardType(.decimalPad)
            .focused($isFocused)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                        Task {
                            usdAmt = try await getConversion(amt: amtConverted, conversionType: convertedType)
                            if usdAmt > 0 {
                                isDoneConverting = true
                                showResetButton = true
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 55)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(Color.cyan)
            )
        
        
    }
}
#Preview {
    ConvertedAmtTextBox(amtConverted: .constant(0.0), usdAmt: .constant(0.0), isDoneConverting: .constant(false), showResetButton: .constant(true), convertedType: "JPY")
}
