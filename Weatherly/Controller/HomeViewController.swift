//
//  HomeViewController.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-06.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension UIImageView
{
    func load(url: URL)
    {
        DispatchQueue.global().async
            { [weak self] in
                if let data = try? Data(contentsOf: url)
                {
                    if let image = UIImage(data: data)
                    {
                        DispatchQueue.main.async
                            {
                                self?.image = image
                        }
                    }
                }
        }
    }
}

public struct weatherToShow
{
    let name: String
    let country: String
    let windSpeed: Double
    let windDeg: Int
    let humidity: Int
    let pressure: Int
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    let icon: String
    let title: String
    let description: String
    
    init(name: String, country: String, windSpeed: Double, windDeg: Int, humidity: Int, pressure: Int, temp: Double, feelsLike: Double, minTemp: Double, maxTemp: Double, icon: String, title: String, description: String)
    {
        self.name = name
        self.country = country
        self.windSpeed = windSpeed
        self.windDeg = windDeg
        self.humidity = humidity
        self.pressure = pressure
        self.temp = temp
        self.feelsLike = feelsLike
        self.minTemp = minTemp
        self.maxTemp = maxTemp
        self.icon = icon
        self.title = title
        self.description = description
    }
}

class HomeViewController: UIViewController, CLLocationManagerDelegate, JSONFetcherDelegate, MKMapViewDelegate
{
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    var jsonFetcher: JSONFetcher?
    var weatherFetcher: currentWeatherModel?
    let apikey = "44b7ba412800701a672fda14ae3f816c"
    var lon = 0.0
    var lat = 0.0
    var countryCode = ""
    var celsiusOrFahrenheit = -273.15
    var celsiusOrFahrenheitLetter = "C"
    // var resultSearchController:UISearchController? = nil
    
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var minMaxTemp: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func updateWeatherButton(_ sender: Any)
    {
        getLocation()
    }
    
    func getLocation()
    {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
        {
            guard let currentLocation = locManager.location else
            {
                return
            }
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            
            self.lon = currentLocation.coordinate.longitude
            self.lat = currentLocation.coordinate.latitude
        }
        
        jsonFetcher = JSONFetcher()
        jsonFetcher?.delegate = self
        jsonFetcher?.fetchWeather(longitute: lon, latitude: lat, apikey: apikey)
    }
    
    func didFinishFetching(_ sender: JSONFetcher)
    {
        weatherFetcher = jsonFetcher!.weather
        print(weatherFetcher!.name)
        
        let currentWeather = weatherToShow(name: weatherFetcher!.name, country: weatherFetcher!.sys.country ?? "", windSpeed: weatherFetcher!.wind.speed, windDeg: weatherFetcher!.wind.deg, humidity: weatherFetcher!.main.humidity, pressure: weatherFetcher!.main.pressure, temp: weatherFetcher!.main.temp, feelsLike: weatherFetcher!.main.feels_like, minTemp: weatherFetcher!.main.temp_min, maxTemp: weatherFetcher!.main.temp_max, icon: weatherFetcher!.weather[0].icon, title: weatherFetcher!.weather[0].main, description: weatherFetcher!.weather[0].description)
        
        cityName.text = currentWeather.name
        countryCode = currentWeather.country
        windLabel.text = "Wind: \(currentWeather.windSpeed)  / \(currentWeather.windDeg)"
        humidityLabel.text = "Humidity: \(currentWeather.humidity)"
        pressureLabel.text = "Pressure: \(currentWeather.pressure)"
        tempLabel.text = "\(currentWeather.temp + celsiusOrFahrenheit) \(celsiusOrFahrenheitLetter)"
        feelsLike.text = "\(currentWeather.feelsLike - celsiusOrFahrenheit) \(celsiusOrFahrenheitLetter)"
        minMaxTemp.text = "H \(currentWeather.maxTemp - celsiusOrFahrenheit) \(celsiusOrFahrenheitLetter)  /  L \(currentWeather.minTemp - celsiusOrFahrenheit) \(celsiusOrFahrenheitLetter)"
        iconView.load(url: URL(string: "http://openweathermap.org/img/wn/\(currentWeather.icon)@2x.png")!)
        
        titleLabel.text = currentWeather.title
        descriptionLabel.text = currentWeather.description
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locManager.requestWhenInUseAuthorization()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        /*resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        searchBar = resultSearchController!.searchBar
        searchBar.placeholder = "Search for places"
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true */
        
        getLocation()
        
        print(lon, lat)
    }
}
