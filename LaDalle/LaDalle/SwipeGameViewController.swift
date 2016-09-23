//
//  SwipeGameViewController.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/23/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit
import CoreLocation

class SwipeGameViewController: UIViewController {

    //MARK: Variables
    var category: Category?
    var businesses: [Business]?
    var userLocation: CLLocation?
    var photoArray: [UIImage]?
    var likes: [String:Int]?
    
    //MARK: Outlets and Actions
    
    @IBOutlet weak var categoryNameLable: UILabel!
    
    @IBOutlet weak var currentPhotoImageView: UIImageView!
    
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        let alias = "test"
        
        updateLikes(for: alias)

        
        showNextImage()
    }
    
    @IBAction func discardTapped(_ sender: UIButton) {
        
        
        showNextImage()
    }
    
    //MARK: App cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPhotosFromLocalBusinesses()
        
        guard let currentCategory = self.category else {
            return
        }
        categoryNameLable.text = currentCategory.title
        
        
        
    }
    
    func updateLikes(for alias: String) {
        print("Updating likes for \(alias) by 1")
        
    }
    
    func showNextImage() {
        print("Showing next image...")
    }
    
    func getPhotosFromLocalBusinesses() {
        var arrayOfPhotos: [UIImage] = []
        print("Getting businesses ....")
        
        print("For each business, 📷 getting photos ....")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
