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

public struct weatherToShow
{
    
}

class HomeViewController: UIViewController, CLLocationManagerDelegate, JSONFetcherDelegate, MKMapViewDelegate
{
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    var jsonFetcher: JSONFetcher?
    var weather: currentWeatherModel?
    let apikey = "44b7ba412800701a672fda14ae3f816c"
    var lon = 0.0
    var lat = 0.0
    
    func didFinishFetching(_ sender: JSONFetcher)
    {
        weather = jsonFetcher!.weather
        print(weather!.name)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locManager.requestWhenInUseAuthorization()
        
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
        
        print(lon, lat)
    }
}
