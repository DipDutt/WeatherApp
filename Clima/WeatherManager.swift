//
//  WeathetManager.swift
//  Clima
//
//  Created by Dip Dutt on 25/11/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didFectchWeather(_ weather:WeatherDescription)
}

struct WeatherManager  {
    // MARK: Properties
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3e63653c728161d9b1e4169082917c00&units=metric"
    var delegate: WeatherManagerDelegate?
    
    // MARK: Create method fetchWeatherValueByName.
    func fetchWeatherValueByCityName(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performNetworking(with: urlString)
        
    }
    
    // MARK: - Create method fetchWeatherValueByCoordinate
    
    func fetchWeatherValueByCoordinate(latitude:CLLocationDegrees, longitute:CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitute)"
        performNetworking(with: urlString)
    }
    
    // MARK: Create method performNetworking
    func performNetworking(with urlString: String) {
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if  error != nil {
                    print("Error: \(error?.localizedDescription ?? "")")
                    return
                }
                
                if let data = data {
                   guard let weather = self.parsejOSON(data: data) else {
                        return
                    }
                    delegate?.didFectchWeather(weather)
                }
            }
            
            task.resume()
        }
        
    }
    
    // MARK: Create parsejOSON method for json decoding.
    func parsejOSON(data:Data)-> WeatherDescription? {
        do {
            
            let decode = try JSONDecoder().decode(WeatherModel.self, from: data)
            let cityName = decode.name
            let temparature = decode.main.temp
            let conditionId = decode.weather[0].id
            let weatherDescription = WeatherDescription(cityName: cityName, temperature: temparature, conditionId: conditionId)
            return weatherDescription
            
        }
        
        catch {
            print("error decoding for:\(error.localizedDescription)")
            return  nil
        }
        
    }
    
}
