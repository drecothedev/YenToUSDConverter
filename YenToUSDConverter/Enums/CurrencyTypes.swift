//
//  CurrencyTypes.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/6/25.
//

import Foundation

// The different currency's this app supports. These will be converted to USD and not the opposite. 
enum CurrencyType: String, CaseIterable {
    case JPY
    case EUR
    case GBP
}
