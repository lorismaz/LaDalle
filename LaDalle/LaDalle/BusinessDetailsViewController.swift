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

    @IBOutlet weak var mapOutlet: MKMapView!
    @IBOutlet weak var actionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //actionsTableView.delegate = self
        //actionsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    
}
