//
//  Query.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/6/25.
//

import Foundation

struct Query: Codable {
    let from: String
    let to: String
    let amount: Double
}
