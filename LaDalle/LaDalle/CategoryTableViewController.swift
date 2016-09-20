//
//  CategoryTableViewController.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/18/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit
import CoreLocation

class CategoryTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    var categories = Category.loadDefaults()
    
    //let searchController = UISearchController(searchResultsController: nil)
    
    var locationManager: CLLocationManager!
    var userCoordinates: Coordinates? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

    }
    
 
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print(">>>>>>>>>>location:")
                    manager.startUpdatingLocation()
                    guard let location = manager.location else { return }
                    
                    let coordinates = Coordinates(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude) )
                    
                    print("Location \(location.coordinate.latitude) x \(location.coordinate.longitude)")
                    
                    
                    // move this to
                    Yelp.sharedInstance.getLocalPlaces(forCategory: "sushi", coordinates: coordinates)
                    
                    
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        
        // Get current row's category
        let category = categories[row]
        
        // Design the cell
        cell.categoryNameLabel.text = category.title

        return cell
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
