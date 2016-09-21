//
//  BusinessDetailsViewController.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/16/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit
import MapKit

class BusinessDetailsViewController: UIViewController {
    
    var business: Business?
    
    @IBOutlet weak var businessMapView: MKMapView!

    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessReviewImageView: UIImageView!
    @IBOutlet weak var businessReviewCountLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateBusinessInfo()
        
    }
    
    func populateBusinessInfo() {
        
        guard let business = business else { return }
        businessNameLabel.text = business.name
        
        let ratingImageName = Business.getRatingImage(rating: business.rating)
        businessReviewImageView.image = UIImage(named: ratingImageName)
        
        //businessReviewImageView.image
        businessReviewCountLabel.text = "Based on " + String(business.reviewCount) + " reviews."
        
    }
    
}
