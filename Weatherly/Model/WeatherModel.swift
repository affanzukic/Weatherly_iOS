//
//  WeatherModel.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-06.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import Foundation

public class currentWeatherModel: Decodable
{
    let coord: coord
    let weather: [weather]
    let base: String
    let main: main
    let visibility: Int = 0
    let wind: wind
    let clouds: clouds
    let dt: Int
    let sys: sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

public class coord: Decodable
{
    let lon: Double
    let lat: Double
}

public class weather: Decodable
{
    let id: Int
    let main: String
    let description: String
    let icon: String
}

public class main: Decodable
{
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

public class wind: Decodable
{
    let speed: Double
    let deg: Int
}

public class clouds: Decodable
{
    let all: Int
}

public class sys: Decodable
{
    let type: Int = 0
    let id: Int = 0
    let country: String? = nil ?? ""
    let sunrise: Int
    let sunset: Int
}
