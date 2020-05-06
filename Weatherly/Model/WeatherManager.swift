//
//  WeatherManager.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-06.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

// Bismillahi rahmani rahim

import Foundation

struct WeatherAPI: Decodable
{
    let weather: weather
    let base: String
    let main: main
    let wind: wind
    let clouds: clouds
    let dt: String
    let sys: sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct coord: Decodable
{
    let lon: Int
    let lat: Int
}

struct weather: Decodable
{
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct main: Decodable
{
    let temp: Double
    let feels_like: String
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct wind: Decodable
{
    let speed: Double
    let deg: Double
}

struct clouds: Decodable
{
    let all: Int
}

struct sys: Decodable
{
    let type: Int
    let id: Int
    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}

let cityName: String? = nil
let state: String? = nil
let country: String? = nil
let APIKey = "44b7ba412800701a672fda14ae3f816c"
let skeletonURL = "api.openweathermap.org/data/2.5/weather?q=\(cityName ?? "Florida"),\(state ?? "Miami"),\(country ?? "US")&appid=\(APIKey)"
