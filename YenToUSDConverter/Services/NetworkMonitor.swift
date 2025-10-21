//
//  NetworkMonitor.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/16/25.
//

import Network
import Foundation
internal import Combine

class NetworkObserver: ObservableObject {
    var queue: DispatchQueue = DispatchQueue(label: "Network Queue")
    var pathMonitor: NWPathMonitor
    @Published var currentStatus: NWPath.Status = .requiresConnection
    init() {
        pathMonitor = NWPathMonitor()
    }
    
    func startMonitor() {
        pathMonitor.start(queue: queue)
    }
    
    func readMonitor() {
        currentStatus = pathMonitor.currentPath.status
        switch currentStatus {
        case .satisfied:
            print("Device is connected!")
        case .unsatisfied:
            print("Device is not conected.")
        case .requiresConnection:
            print("Device will need connection.")
        @unknown default:
            print("Unknown Error.")
        }
    }
}
