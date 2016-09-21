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
    var coordinates: Coordinates?
    //let searchController = UISearchController(searchResultsController: nil)
    
    var locationManager: CLLocationManager!
    var userCoordinates: Coordinates? = nil
    //let yelp = Yelp.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "o-2-blured"))
        self.tableView.backgroundView?.clipsToBounds = true
        
    }
    
 
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print(">>>>>>>>>>location:")
                    manager.startUpdatingLocation()
                    guard let location = manager.location else { return }
                    
                    self.coordinates = Coordinates(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude) )
                    
                    print("Location \(location.coordinate.latitude) x \(location.coordinate.longitude)")
                    
                    
                    // move this to
                    //yelp.getLocalPlaces(forCategory: "sushi", coordinates: coordinates)
                    
                    
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

    
    
    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let category = categories[row]
        
        //displayBusinesses(for: category)
        
    }
    
//    func displayBusinesses(for category: Category) {
//        
//        // Get current location
//        guard let location = locationManager.location else { print("need access to location") ; return }
//        let latitude = location.coordinate.latitude
//        let longitude = location.coordinate.longitude
//        
//        let coordinates = Coordinates(latitude: latitude, longitude: longitude)
//        
//        // search local places
//        let businesses = yelp.getLocalPlaces(forCategory: category.alias, coordinates: coordinates)
//        
//        performSegue(withIdentifier: "ToBusinessTable", sender: nil)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ToBusinessTable" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destination = segue.destination as? BusinessTableViewController else { return }
                
                let category = categories[indexPath.row]
                destination.categoryAlias = category.alias
                
                
                //get current location
                guard let location = locationManager.location else { return }
                
                self.coordinates = Coordinates(latitude: Double(location.coordinate.latitude), longitude: Double(location.coordinate.longitude) )
                
                destination.coordinates = coordinates
            }
        }
        
    }
 

}
