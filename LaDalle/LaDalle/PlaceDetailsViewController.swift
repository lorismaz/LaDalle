//
//  PlaceDetailsViewController.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/16/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit
import MapKit

class PlaceDetailsViewController: UIViewController {

    @IBOutlet weak var mapOutlet: MKMapView!
    @IBOutlet weak var actionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //actionsTableView.delegate = self
        //actionsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
