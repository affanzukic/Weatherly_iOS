//
//  SettingsViewController.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-09.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit

var access = UnitSettings()

class SettingsViewController: UITableViewController {
    
    let settings = ["Temperature units",
    "Wind units",
    "Feedback",
    "About"]
    var myIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.title = "Settings"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return settings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = settings[indexPath.row]
        cell.textLabel?.textColor = UIColor.link
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22.0, weight: .heavy)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        myIndex = indexPath.row
        
        let aboutAlert = UIAlertController(title: "About", message: "This applicaton is made for JU 'Četvrta gimnazija' Ilidža. API used: OpenWeatherMap API. Used Swift, JSON Parsing, HTML request handling and so on.", preferredStyle: .alert)
        let feedbackAlert = UIAlertController(title: "Feedback", message: "Please leave feedback at App Store!", preferredStyle: .alert)
        
        if myIndex == 3
        {
            aboutAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(aboutAlert, animated: true, completion: nil)
        }
        else if myIndex == 2
        {
            feedbackAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(feedbackAlert, animated: true, completion: nil)
        }
        else
        {
            access.setName(nameToSet: settings[myIndex])
            print(settings[myIndex])
            performSegue(withIdentifier: "unitSegue", sender: self)
        }
    }
}
