//
//  ResetButton.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/16/25.
//

import SwiftUI

struct ResetButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(width: 50, height: 25)
                .padding()
            Text("Reset")
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    ResetButton()
}
