//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var weatherManager = WeatherManager()
    let loactionManager = CLLocationManager()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
        
        loactionManager.delegate = self
        loactionManager.requestWhenInUseAuthorization()
        loactionManager.requestLocation()
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    // MARK: - create pressCurrentLocation action button to reupdate device current location.
    @IBAction func pressCurrentLocation(_ sender: UIButton) {
        loactionManager.requestLocation()
    }
}

// MARK: - create an Extension.
extension WeatherViewController: UITextFieldDelegate,WeatherManagerDelegate {
    
    // MARK: - Create action button function for search in a textfield.
    @IBAction func searchButton(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    // MARK: - textFieldShouldReturn method to dismiss keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

    // MARK: - textFieldShouldEndEditin method without editing any text on a textField.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "type something"
            return false
        }
    }
    
    // MARK: - textFieldDidEndEditing method to use after editing text on a textField.
    func textFieldDidEndEditing(_ textField: UITextField) {
        let city = searchTextField.text ?? ""
        weatherManager.fetchWeatherValueByCityName(cityName:city )
        searchTextField.text = ""
    }
    
    // MARK: -  didFectchWeather method pass weatherValue From WeatherManager Class.
    func didFectchWeather(_ weather: WeatherDescription) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = "\(weather.temperatureDescription)"
            self.conditionImageView.image = UIImage(systemName: weather.weatherconditionDescription)
        }
    }
}

// MARK: - create extension of ViewController for location manager.

extension WeatherViewController: CLLocationManagerDelegate {
    
    // MARK: - create locationManager method for get device current location.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            loactionManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherManager.fetchWeatherValueByCoordinate(latitude: latitude, longitute: longitude)
            
        }
    }
    
    // MARK: - locationManager meathod for if can't get the device current location in timely manner.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("getting error")
    }
}
