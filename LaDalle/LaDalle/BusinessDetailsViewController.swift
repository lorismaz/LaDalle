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

class BusinessDetailsViewController: UIViewController, MKMapViewDelegate {
    
    //MARK: Global Declarations
    var business: Business?
    var coordinates: Coordinates?
    
    //MARK: Properties and Outlets
    @IBOutlet weak var businessMapView: MKMapView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessReviewImageView: UIImageView!
    @IBOutlet weak var businessReviewCountLabel: UILabel!
    
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
        
        shareSheetController()
        
    }
    
    //MARK: - Annotations
    //MARK: - Overlays
    //MARK: - Map setup
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businessMapView.delegate = self
        
        populateBusinessInfo()
        addAnnotation()
        zoomToBusinessLocation()
    }
    
    func zoomToBusinessLocation() {
        guard let currentBusiness = self.business else { return }
        guard let userCoordinate = self.coordinates else { return }
        
        let businessLocation = CLLocation(latitude: currentBusiness.coordinate.latitude, longitude: currentBusiness.coordinate.longitude)
        //do a check for incorrect region
        
        
        //get distance between user and business
        // return 
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        
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
    
}
