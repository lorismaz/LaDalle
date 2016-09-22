//
//  BusinessDetailsViewController.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/16/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit
import MapKit

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
        
        zoomToUserLocation()
        
        populateBusinessInfo()
        
    }
    
    func zoomToUserLocation() {
    
        guard let userCoordinates = self.coordinates else { return }
        
        let userLocation = CLLocation(latitude: userCoordinates.latitude, longitude: userCoordinates.longitude)
        //do a check for incorrect region
        
        let regionRadius: CLLocationDistance = 1200
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, regionRadius, regionRadius)
        businessMapView.setRegion(coordinateRegion, animated: true)
    
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
