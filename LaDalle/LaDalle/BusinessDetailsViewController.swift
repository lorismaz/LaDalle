//
//  BusinessDetailsViewController.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/16/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BusinessDetailsViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Global Declarations
    var business: Business?
    var userLocation: CLLocation?
    var reviews: [Review] = [Review]()
    var photos: [String] = []
    
    //MARK: Properties and Outlets
    @IBOutlet weak var businessMapView: MKMapView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessReviewImageView: UIImageView!
    @IBOutlet weak var businessReviewCountLabel: UILabel!
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
        
        shareSheetController()
        
    }
    
    //MARK: - Annotations
    //MARK: - Overlays
    //MARK: - Map setup
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentBusiness = business else { return }
        
        currentBusiness.getReviews(completionHandler: { (reviews) in
            
            self.main.addOperation {
                self.reviews = reviews
                
                for review in reviews {
                    print("Review: \(review.text)")
                    //self.businessReviewLabel.text = review.text
                }
                self.reviewTableView.reloadData()
            }
            
        })
        
        currentBusiness.getPhotos(completionHandler: { (photos) in
            
            self.main.addOperation {
                self.photos = photos
                
                for photo in photos {
                    print("Photourl: \(photo)")
                    //self.businessReviewLabel.text = review.text
                }
                self.reviewTableView.reloadData()
            }
            
        })
        
        //Delegates
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        // set estimated height
        reviewTableView.estimatedRowHeight = 95.0
        // set automaticdimension
        reviewTableView.rowHeight = UITableViewAutomaticDimension
        
        businessMapView.delegate = self
        
        
        
        populateBusinessInfo()
        addAnnotation()
        zoomToBusinessLocation()
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
    
    func zoomToBusinessLocation() {
        guard let currentBusiness = self.business else { return }
        guard let userLocation = self.userLocation else { return }
        
        let businessLocation = CLLocation(latitude: currentBusiness.coordinate.latitude, longitude: currentBusiness.coordinate.longitude)
        
        //get distance between user and business
        let distanceFromBusiness = userLocation.distance(from: businessLocation)
        print("Distance: \(distanceFromBusiness) meters")
        //let distanceFromBusiness = userCoordinate.distance(from: currentBusiness.coordinate)
        let regionRadius: CLLocationDistance = distanceFromBusiness * 10
        print("Region Radius: \(regionRadius) meters")
        
        
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(businessLocation.coordinate, regionRadius, regionRadius)
        businessMapView.setRegion(coordinateRegion, animated: true)
    
    }
    
    func addAnnotation(){
        
        guard let currentBusiness = business else { return }
        
        businessMapView.addAnnotation(currentBusiness)
    }
    
    func populateBusinessInfo() {
        
        guard let business = business else { return }
        businessNameLabel.text = business.name
        
        let ratingImageName = Business.getRatingImage(rating: business.rating)
        businessReviewImageView.image = UIImage(named: ratingImageName)
        
        //businessReviewImageView.image
        businessReviewCountLabel.text = "Based on " + String(business.reviewCount) + " reviews."
        
    }
    
    func shareSheetController() {
        guard let business = business else { return }
        
        var activities: [Any] = []
        
        let message = "Trying out \(business.name), thanks to La Dalle by @lorismaz & the new @Yelp Fusion API"
        
        activities.append(message)
        
        if let image: UIImage = Business.getImage(from: business.imageUrl) {
            activities.append(image)
        }
        
        if business.url != "" {
            activities.append(business.url)
        }
        
        
        let shareSheet = UIActivityViewController(activityItems: activities, applicationActivities: nil)
    
        shareSheet.excludedActivityTypes =  [
            UIActivityType.postToWeibo,
            UIActivityType.mail,
            UIActivityType.print,
            UIActivityType.copyToPasteboard,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo
        ]
        
        present(shareSheet, animated: true, completion: nil)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        
        // Get current row's category
        let review = reviews[row]
        
        // Design the cell
        cell.reviewContentTextView.text = review.text
        cell.userNameLabel.text = review.user.name
        
        return cell
    }
    
}
