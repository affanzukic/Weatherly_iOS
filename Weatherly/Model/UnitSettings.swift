//
//  UnitSettings.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-10.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import Foundation

var unitSettingsName: String = ""

struct UnitSettings
{
    var useFahrenheit: Bool = false
    var useKnots: Bool = false
    
    var kelvinConversion: Double = 0.0
    var windConversion: Double = 0.0
    var tempSign: String = ""
    var windSign: String = ""
    
    mutating func setName(nameToSet: String)
    {
        unitSettingsName = nameToSet
    }
    
    func getName() -> String
    {
        print(unitSettingsName)
        return unitSettingsName
    }
    
    func getTempUnit() -> String
    {
        return tempSign
    }
    
    func getWindUnit() -> String
    {
        return windSign
    }
    
    func getKelvinConversion() -> Double
    {
        return kelvinConversion
    }
    
    func getWindConversion() -> Double
    {
        return windConversion
    }
    
    
    mutating func setKelvinConversion(state: Bool)
    {
        if state == true
        {
            kelvinConversion = 273.15 - 32.0
            tempSign = " °F"
        }
        else
        {
            kelvinConversion = 273.15
            tempSign = " °C"
        }
    }
    
    mutating func setWindConversion(state: Bool)
    {
        if state == true
        {
            windConversion = 1.9
            windSign = " kn"
        }
        else
        {
            windConversion = 1.0
            windSign = " m/s"
        }
    }
}
