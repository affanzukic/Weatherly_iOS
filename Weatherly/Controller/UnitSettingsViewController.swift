//
//  UnitSettingsViewController.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-10.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit

var unitAccess = UnitSettings()

class UnitSettingsViewController: UIViewController
{
    @IBOutlet weak var firstSwitch: UISwitch!
    @IBOutlet weak var secondSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var setXLabel: UILabel!
    @IBOutlet weak var setYLabel: UILabel!
    @IBOutlet weak var switchView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        switchView.layer.cornerRadius = 10
        switchView.clipsToBounds = true
        
        titleLabel.text = unitAccess.getName()
        firstSwitch.isOn = true
        secondSwitch.isOn = false
        
        if titleLabel.text == "Temperature units"
        {
            descriptionLabel.text = "Here you can choose between units for temperature. Choose between Celsius and Fahrenheit."
            setXLabel.text = "Use Celsius"
            setYLabel.text = "Use Fahrenheit"
        }
        else
        {
            descriptionLabel.text = "Here you can choose between units for wind speed. Choose between meters per second (m/s) and knots (kn)."
            setXLabel.text = "Use m/s"
            setYLabel.text = "Use kn"
        }
    }
    
    @IBAction func firstSwitchChange(_ sender: UISwitch)
    {
        if firstSwitch.isOn == true
        {
            firstSwitch.isOn = false
            secondSwitch.isOn = true
            
            if titleLabel.text == "Temperature units"
            {
                unitAccess.setKelvinConversion(state: true)
            }
            else
            {
                unitAccess.setWindConversion(state: true)
            }
        }
        else
        {
            firstSwitch.isOn = true
            secondSwitch.isOn = false
            
            if titleLabel.text == "Temperature units"
            {
                unitAccess.setKelvinConversion(state: false)
            }
            else
            {
                unitAccess.setWindConversion(state: false)
            }
        }
    }
    
    @IBAction func secondSwitchChange(_ sender: UISwitch)
    {
        if secondSwitch.isOn == true
        {
            secondSwitch.isOn = false
            firstSwitch.isOn = true
            
            if titleLabel.text == "Temperature units"
            {
                unitAccess.setKelvinConversion(state: false)
            }
            else
            {
                unitAccess.setWindConversion(state: false)
            }
        }
        else
        {
            secondSwitch.isOn = true
            firstSwitch.isOn = false
            
            if titleLabel.text == "Temperature units"
            {
                unitAccess.setKelvinConversion(state: true)
            }
            else
            {
                unitAccess.setWindConversion(state: true)
            }
        }
    }
}
