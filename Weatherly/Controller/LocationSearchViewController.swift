//
//  LocationSearchViewController.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-08.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchViewController: UITableViewController
{
    
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? = nil
    var hvc = HomeViewController()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return matchingItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = ""

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LocationSearchViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        let lat = hvc.lat
        let lon = hvc.lon
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        request.naturalLanguageQuery = searchBarText
        request.region = MKCoordinateRegion(center: coord, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        let search = MKLocalSearch(request: request)
        
        search.start{ (response, error) in
            guard let response = response else { return }
            
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}