//
//  WeatherDescription.swift
//  Clima
//
//  Created by Dip Dutt on 10/3/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct WeatherDescription {
    let cityName:String
    let temperature: Double
    let conditionId:Int
    
    // MARK: create a computed property for temperatureDescription.
    
    var temperatureDescription: String {
        return String(format: "%.1f", temperature)
       
    }
    
    // MARK: create a computed property for weather condition Dscription.
    
    var weatherconditionDescription: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
