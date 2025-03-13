//
//  WeatherModel.swift
//  Clima
//
//  Created by Dip Dutt on 10/3/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let name:String
    let main:Main
    let weather: [Weather]
}


struct Main: Codable {
    let temp:Double
}

struct Weather: Codable {
    let description: String
    let id:Int
}

