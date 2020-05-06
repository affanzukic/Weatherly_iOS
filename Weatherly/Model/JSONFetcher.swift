//
//  JSONFetcher.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-06.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import Foundation

class JSONFetcher
{
    var weather:currentWeatherModel?
    var delegate:JSONFetcherDelegate?
    
    init()
    {
        self.weather = nil
    }
    
    func fetchWeather(longitute: Int, latitude : Int, apikey: String)
    {
        let urlString = "https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=439d4b804bc8187953eb36d2a8c26a02"
        
        if let url = URL(string: urlString)
        {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data
                {
                    do
                    {
                        self.weather = try JSONDecoder().decode(currentWeatherModel.self, from: data)
                        self.didFetchJSON()
                    }
                    catch let error
                    {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func didFetchJSON()
    {
        delegate?.didFinishFetching(self)
    }
}
