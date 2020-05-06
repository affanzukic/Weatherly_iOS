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
    let weather: [weather]
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

public class coord: Decodable
{
    let lon: Int
    let lat: Int
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
    let deg: Double
}

public class clouds: Decodable
{
    let all: Int
}

public class sys: Decodable
{
    let type: Int
    let id: Int
    let message: Double
    let country: String
    let sunrise: Int
    let sunset: Int
}
