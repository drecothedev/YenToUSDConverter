//
//  BlinkingOtter.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/6/25.
//
internal import Combine
import SwiftUI
// This view is responsible for showing the user the app is ready to process their request. The view chooses between two different otters, one with its eyes open and one with its eyes closed, simulating blinking. 
struct BlinkingOtter: View {
    @State private var isBlinking = false
    
    let eyesOpenOtter: Image = Image("OtterMascot")
    let eyesClosedOtter: Image = Image("EyesClosedOtter")
    let eyesOpenTimer = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect()
    let eyesClosedTimer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    var body: some View {
        if !isBlinking {
            eyesOpenOtter
                .resizable()
                .frame(width: 100, height: 100)
                .onReceive(eyesOpenTimer) { _ in
                    isBlinking = true
                }
        } else {
            eyesClosedOtter
                .resizable()
                .frame(width: 100, height: 100)
                .onReceive(eyesClosedTimer) { _ in
                    isBlinking = false
                }
        }
        
    }
}

#Preview {
    BlinkingOtter()
}
