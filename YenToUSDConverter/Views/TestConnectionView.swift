//
//  TestConnectionView.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/16/25.
//

import SwiftUI

struct TestConnectionView: View {
    @StateObject var networkManager = NetworkObserver()
    var body: some View {
        Button("TEST CONNECTION") {
            networkManager.startMonitor()
            networkManager.readMonitor()
        }
    }
}

#Preview {
    TestConnectionView()
}
