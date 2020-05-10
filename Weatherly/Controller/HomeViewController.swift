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

protocol HandleMapSearch
{
    func dropPinZoomIn(placemark: MKPlacemark)
}

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
    var metricOrImperialTemp = 273.15
    var metricOrImperialTempSign = " °C"
    var metricOrImperialWind = 1.0
    var metricOrImperialWindSign = " m/s"
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    
    var name: String? = nil
    
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
    @IBOutlet weak var imperialUnitSwitch: UISwitch!
    
    
    @IBAction func imperialUnitChange(_ sender: UISwitch)
    {
        if imperialUnitSwitch.isOn == true
        {
            metricOrImperialTemp = 273.15 - 32.0
            metricOrImperialTempSign = " °F"
            metricOrImperialWind = 1.9
            metricOrImperialWindSign = " kn"
        }
        else
        {
            metricOrImperialTemp = 273.15
            metricOrImperialTempSign = " °C"
            metricOrImperialWind = 1.0
            metricOrImperialWindSign = " m/s"
        }
    }
    
    @IBAction func updateWeatherButton(_ sender: Any)
    {
        locManager.requestLocation()
        
        jsonFetcher = JSONFetcher()
        jsonFetcher?.delegate = self
        jsonFetcher?.fetchWeather(longitute: lon, latitude: lat, apikey: apikey)
    }
    
    func didFinishFetching(_ sender: JSONFetcher)
    {
        weatherFetcher = jsonFetcher!.weather
        print(weatherFetcher!.name)
        
        let currentWeather = weatherToShow(name: weatherFetcher!.name, country: weatherFetcher!.sys.country ?? "", windSpeed: weatherFetcher!.wind.speed, windDeg: weatherFetcher!.wind.deg, humidity: weatherFetcher!.main.humidity, pressure: weatherFetcher!.main.pressure, temp: weatherFetcher!.main.temp, feelsLike: weatherFetcher!.main.feels_like, minTemp: weatherFetcher!.main.temp_min, maxTemp: weatherFetcher!.main.temp_max, icon: weatherFetcher!.weather[0].icon, title: weatherFetcher!.weather[0].main, description: weatherFetcher!.weather[0].description)
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        let dateTimeString = formatter.string(from: currentDateTime)
        
        DispatchQueue.main.async
            {
                self.cityName.text = currentWeather.name
                self.countryCode = currentWeather.country
                self.windLabel.text = "Wind: \(Int(currentWeather.windSpeed * self.metricOrImperialWind)) \(self.metricOrImperialWindSign)  / \(currentWeather.windDeg)°"
                self.humidityLabel.text = "Humidity: \(currentWeather.humidity)"
                self.pressureLabel.text = "Pressure: \(currentWeather.pressure) hPa"
                self.tempLabel.text = "\(Int(currentWeather.temp - self.metricOrImperialTemp)) \(self.metricOrImperialTempSign)"
                self.feelsLike.text = "\(Int(currentWeather.feelsLike - self.metricOrImperialTemp)) \(self.metricOrImperialTempSign)"
                self.minMaxTemp.text = "H \(Int(currentWeather.maxTemp - self.metricOrImperialTemp)) \(self.metricOrImperialTempSign)  /  L \(Int(currentWeather.minTemp - self.metricOrImperialTemp)) \(self.metricOrImperialTempSign)"
                self.iconView.load(url: URL(string: "https://openweathermap.org/img/wn/\(currentWeather.icon)@2x.png")!)
            
                self.titleLabel.text = currentWeather.title
                self.descriptionLabel.text = currentWeather.description.capitalized
                self.lastUpdatedLabel.text = "Last updated: \(dateTimeString)"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedAlways
        {
            print("Location services enabled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        self.lat = manager.location?.coordinate.latitude as! Double
        self.lon = manager.location?.coordinate.longitude as! Double
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imperialUnitSwitch.isOn = false
        iconView.layer.cornerRadius = 10
        
        locManager.requestAlwaysAuthorization()
        locManager.delegate = self
        locManager.startMonitoringSignificantLocationChanges()
        locManager.startUpdatingLocation()
        
        locManager.requestLocation()
        
        jsonFetcher = JSONFetcher()
        jsonFetcher?.delegate = self
        jsonFetcher?.fetchWeather(longitute: lon, latitude: lat, apikey: apikey)
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearch") as! LocationSearchViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.handleMapSearchDelegate = self
        
        print(lon, lat)
    }
}

extension HomeViewController: HandleMapSearch
{
    func dropPinZoomIn(placemark: MKPlacemark)
    {
        selectedPin = placemark
        self.lat = placemark.coordinate.latitude
        self.lon = placemark.coordinate.longitude
        
        jsonFetcher = JSONFetcher()
        jsonFetcher?.delegate = self
        jsonFetcher?.fetchWeather(longitute: placemark.coordinate.longitude, latitude: placemark.coordinate.latitude, apikey: apikey)
    }
}

