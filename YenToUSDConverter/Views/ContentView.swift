//
//  ContentView.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/4/25.
//

internal import Combine
import Network
import SwiftUI

struct ContentView: View {
    @StateObject var networkManager = NetworkObserver()
    @State private var isConnected: Bool = false
    @State private var convertedAmt: Double = .zero
    @State private var usdAmt: Double = 0.0
    @State private var conversionAmt: Double = 0.0
    @State private var selectedCurrency: String = CurrencyType.JPY.rawValue
    @State private var showPicker: Bool = false
    @State private var isDoneConverting: Bool = false
    @State private var showResetButton: Bool = false
    
    let timerToReset = Timer.publish(every: 10.0, on: .main, in: .common).autoconnect()
    let timerToCheckConnection = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        resetParameters()
                    }, label: {
                        ResetButton()
                    })
                    Spacer()
                    Button(action: {
                        showPicker.toggle()
                    }) {
                        switch selectedCurrency {
                        case "JPY":
                            Image(systemName: "yensign.circle")
                        case "EUR":
                            Image(systemName: "eurosign.circle")
                        case "GBP":
                            Image(systemName: "sterlingsign.circle")
                        default:
                            Image(systemName: "questionmark.circle")
                        }
                    }
                    .font(.title2)
                    .foregroundColor(.white)
                    .popover(isPresented: $showPicker, arrowEdge: .top) {
                        PopoverView(selectedCurrency: $selectedCurrency, showPicker: $showPicker)
                            .presentationCompactAdaptation(.popover)
                    }
                }
                .padding()
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 5)
                .padding(.horizontal)
                .onReceive(timerToCheckConnection) { _ in
                    if !isConnected {
                        networkManager.startMonitor()
                        networkManager.readMonitor()
                        switch networkManager.currentStatus {
                        case .satisfied:
                            isConnected = true
                            print(networkManager.currentStatus)
                        case .unsatisfied:
                            isConnected = false
                            print(networkManager.currentStatus)
                        case .requiresConnection:
                            isConnected = false
                            print(networkManager.currentStatus)
                        @unknown default:
                            print("Unknown fatal error")
                        }
                    } else {
                        print("User is connected :)")
                    }
                }
                ScrollView {
                    VStack(spacing: 20) {
                        if isConnected {
                            if !isDoneConverting {
                                BlinkingOtter()
                            } else {
                                CelebratingOtter()
                                    .onReceive(timerToReset) { _ in
                                        resetParameters()
                                    }
                            }
                        } else {
                            VStack {
                                Text("Please connect to internet. ")
                                    .foregroundStyle(Color.white)
                                Image("SadOtter")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                        }
                        ConvertedAmtTextBox(
                            amtConverted: $convertedAmt,
                            usdAmt: $usdAmt,
                            isDoneConverting: $isDoneConverting, showResetButton: $showResetButton,
                            convertedType: selectedCurrency
                        )
                        USDTextBox(amtToConvert: usdAmt)
                            .padding()
                    }
                    .padding(.horizontal)
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
    }
    func resetParameters() {
        isDoneConverting = false
        usdAmt = 0.0
        conversionAmt = 0.0
        convertedAmt = 0.0
        showPicker = false
        showResetButton = false
        networkManager.startMonitor()
        networkManager.readMonitor()
    }
}

#Preview {
    ContentView()
}


