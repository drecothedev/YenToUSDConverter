//
//  ConversionResponse.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/6/25.
//

import Foundation

// The full JSON response we receive from the data source.
struct ConversionResponse: Codable {
    let success: Bool
    let query: Query
    let info: Info
    let date: String
    let result: Double
}
