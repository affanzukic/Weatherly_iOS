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
    var handleMapSearchDelegate: HandleMapSearch? = nil
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView? = nil
    var hvc = HomeViewController()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    func parseAddress(selectedItem: MKPlacemark) -> String
    {
        return selectedItem.country!
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return matchingItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
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
