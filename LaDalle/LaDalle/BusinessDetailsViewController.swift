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
    
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessReviewImageView: UIImageView!
    @IBOutlet weak var businessReviewCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let business = business else { return }
        
        //let businessDetails = Business.getDetails(for: business)
        businessNameLabel.text = business.name
        //businessImageView.image = business.loadImage(from: business.imageUrl)
        if let image = Business.getImage(from: business.imageUrl) {
            businessImageView.image = image
        }
        //businessReviewImageView.image
        businessReviewCountLabel.text = String(business.reviewCount) + " reviews."
        
        // Do any additional setup after loading the view.
    }
    
        
}
