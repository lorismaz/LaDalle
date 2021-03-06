//
//  BusinessTableViewController.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/16/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit
import CoreLocation

class BusinessTableViewController: UITableViewController {

    // MARK: Variables
    var businesses = [Business]()
    var category: Category?
    var userLocation: CLLocation?
    
    //MARK: Outlets and Actions
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    // MARK: App Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentCategory = self.category else { return }
        
        categoryNameLabel.text = currentCategory.title
        
        print(">>>let's do this>>>")
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "o-2-blured"))
        self.tableView.backgroundView?.clipsToBounds = true
        
        reload()
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
            
            guard let currentCategory = self.category else { return }
            
            if let currentLocation = self.userLocation {
                print(currentCategory.alias)
                print(currentLocation)
                
                Business.getLocalPlaces(forCategory: currentCategory.alias, coordinates: currentLocation, completionHandler: { (business) in
                    
                    self.main.addOperation {
                        //print("reload")
                        self.businesses = business
                        self.tableView.reloadData()
                    }
                    
                })
                
                
            }
            
        }
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell

        let row = indexPath.row
        let business = businesses[row]
        
        cell.businessNameLabel.text = business.name
    
        async.addOperation {
            
            Business.getImageAsync(from: business.imageUrl, completionHandler: { (image) in
                
                self.main.addOperation {
                    if (tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false) {
                        
                        let animation = {
                            cell.businessImageView.image = image
                        }
                        
                        UIView.transition(with: cell.businessImageView, duration: 0.8, options: .transitionCrossDissolve, animations: animation, completion: nil)
                    }
                }
                
            })
            
        }
        
        return cell
    }


    // MARK: - Navigation

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let business = businesses[row]
        
        displayBusiness(business: business)
    }
    
    func displayBusiness(business: Business) {
        performSegue(withIdentifier: "ToBusinessDetail", sender: business)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // pass Business data
        if segue.identifier == "ToBusinessDetail" {
            
            guard let business = sender as? Business else { return }
            guard let businessDetailViewController = segue.destination as? BusinessDetailsViewController else { return }
            
            businessDetailViewController.business = business
            businessDetailViewController.userLocation = self.userLocation
        }
        
    }

}
