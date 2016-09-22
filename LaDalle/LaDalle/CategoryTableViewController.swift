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
    var userLocation: CLLocation?
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.startUpdatingLocation()
        
//        reload()
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "o-2-blured"))
        self.tableView.backgroundView?.clipsToBounds = true
        
    }
    
    //The Main OperationQueue is where any UI changes or updates happen
    private let main = OperationQueue.main
    
    //The Async OperationQueue is where any background tasks such as
    //Loading from the network, and parsing JSON happen.
    //This makes sure the Main UI stays sharp, responsive, and smooth
    private let async: OperationQueue = {
        //The Queue is being created by this closure
        let operationQueue = OperationQueue()
        //This represents how many tasks can run at the same time, in this case 8 tasks
        //That means that we can load 8 images at a time
        operationQueue.maxConcurrentOperationCount = 8
        return operationQueue
    }()
    
    func reload() {
        
        async.addOperation {
            
            if let userLocation = self.userLocation {
                print(userLocation)
                
                Category.getCategories(for: userLocation, categorySearchCompletionHandler: { (category) in
                    
                    self.main.addOperation {
                        //print("reload")
                        self.categories = category
                        self.tableView.reloadData()
                    }
                    
                })
                
            } else {
                print(">>>>Coordinates not present")
            }
            
        }
        
    }
 
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error finding location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
            if userLocation == nil {
                userLocation = locations.first
                reload()
            } else {
                guard let latestLocation = locations.first,
                      let distanceFromPreviousLocation = userLocation?.distance(from: latestLocation)
                    else { return }
                
                if distanceFromPreviousLocation > 200 {
                    userLocation = latestLocation
                    print("reloading because distance")
                    reload()
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
                destination.category = category
                
                destination.userLocation = userLocation
            }
        }
        
    }
 

}
