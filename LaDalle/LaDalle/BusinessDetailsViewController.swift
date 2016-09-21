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
        
        var ratingImageName = "rating0"
        
        switch business.rating {
        case 5:
            ratingImageName = "rating50"
        case 4.5:
            ratingImageName = "rating45"
        case 4:
            ratingImageName = "rating40"
        case 3.5:
            ratingImageName = "rating35"
        case 3:
            ratingImageName = "rating30"
        case 2.5:
            ratingImageName = "rating25"
        case 2:
            ratingImageName = "rating20"
        case 1.5:
            ratingImageName = "rating15"
        case 1:
            ratingImageName = "rating10"
        default:
            break
        }
        
        businessReviewImageView.image = UIImage(named: ratingImageName)
        
        //businessReviewImageView.image
        businessReviewCountLabel.text = "Based on " + String(business.reviewCount) + " reviews."
        
        // Do any additional setup after loading the view.
    }
    
        
}
