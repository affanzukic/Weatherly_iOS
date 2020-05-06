//
//  HomeViewController.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-06.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, JSONFetcherDelegate
{
    var locationManager: CLLocationManager!
    var jsonFetcher:JSONFetcher?
    var weather:currentWeatherModel?
    
    func didFinishFetching(_ sender: JSONFetcher) {
        weather = jsonFetcher!.weather
        print(weather!.name)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        {
            let location = locations.last! as CLLocation
        }
        
        jsonFetcher = JSONFetcher()
        jsonFetcher?.delegate = self
        jsonFetcher?.fetchWeather(longitute: 139, latitude: 35, apikey: "439d4b804bc8187953eb36d2a8c26a02")
    }
}
