//
//  USDTextBox.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/6/25.
//

import SwiftUI

struct USDTextBox: View {
    var amtToConvert: Double
    var body: some View {
        Text(amtToConvert.formatted(.currency(code: "USD")))
            .padding()
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity, minHeight: 55)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(Color.cyan)
                )
    }
}


#Preview {
    USDTextBox(amtToConvert: 0.0)
}
