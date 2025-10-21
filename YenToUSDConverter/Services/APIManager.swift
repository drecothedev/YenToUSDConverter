//
//  APIManager.swift
//  YenToUSDConverter
//
//  Created by Andre jones on 10/6/25.
//

import Foundation

// This function handles creating and returning our URL request which will be used to for our getConvsersion method.
func prepareURLRequest(amt: Double, conversionType: String) -> URLRequest {
    let url = URL(string: "https://currency-conversion-and-exchange-rates.p.rapidapi.com/convert?from=\(conversionType)&to=USD&amount=" + String(amt))!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("currency-conversion-and-exchange-rates.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
    request.setValue("yourkey", forHTTPHeaderField: "x-rapidapi-key")
    
    return request
}

// This function provides our GET service. Uses Concurrency to delegate the method off of the main thread. Depending on the users conversion type ( currency ), and amout, we send our request to our api.
func getConversion(amt: Double, conversionType: String) async throws -> Double {
    var convertedAmt = 0.0 // The result of our conversion.
    
    let request = prepareURLRequest(amt: amt, conversionType: conversionType)
    let response = try await URLSession.shared.data(for: request)
    let data = response.0 // Collects the raw data ( aka bytes ) from our response
    let extraDetails = response.1 // Collects our response ( 200, 401, 404, etc. )
    
    if let jsonString = String(data: data, encoding: .utf8) {
        print("RAW JSON:\n", jsonString)
    }
    
    // Define and use a decoder to decode data into our conversion response model.
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(ConversionResponse.self, from: data)
        print(decodedData.result)
        convertedAmt = decodedData.result
    } catch {
        print("Decoding Error", error)
    }
    
    return convertedAmt
}
