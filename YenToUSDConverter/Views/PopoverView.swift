//
//  PopoverView.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/6/25.
//

import SwiftUI

struct PopoverView: View {
    @Binding var selectedCurrency: String
    @Binding var showPicker: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Select an Option")
                .font(.headline)
                .padding(.bottom, 5)
            
            Picker("Currencies", selection: $selectedCurrency) {
                ForEach(CurrencyType.allCases, id: \.self) { currency in
                    Text(currency.rawValue)
                        .tag(currency.rawValue)
                }
            }
            .pickerStyle(.inline)
            
            Divider()
            
            Button("Done") {
                showPicker = false
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .padding()
        .frame(width: 250)
    }
}

#Preview {
    PopoverView(selectedCurrency: .constant("JPY"), showPicker: .constant(true))
}
