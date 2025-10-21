//
//  CelebratingOtter.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/6/25.
//

import SwiftUI
internal import Combine

struct CelebratingOtter: View {
    @State private var yOffset: Double = 0
    let celebratinOtter: Image = Image("CelebratingOtter")
    let timer = Timer.publish(every: 0.7, on: .main, in: .common).autoconnect()
    var body: some View {
        celebratinOtter
            .resizable()
            .frame(width: 100, height: 100)
            .offset(y: yOffset)
            .animation(.spring, value: yOffset)
            .onReceive(timer) { _ in
                if yOffset == 0.0 {
                    yOffset -= 20
                } else {
                    yOffset = 0
                }
            }
    }
}

#Preview {
    CelebratingOtter()
}
