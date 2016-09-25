//
//  SwipeGameViewController.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/23/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit
import CoreLocation

enum Subject {
    case unknown
    case food
    case people
    case place
}

struct Photo {
    let image: UIImage
    let businessId: String
    let subject: Subject = .unknown
}

class SwipeGameViewController: UIViewController {

    //MARK: Variables
    var category: Category?
    var businesses: [Business]?
    var userLocation: CLLocation?
    var photoArray: [Photo] = []
    var photoIndex: Int = 0
    var likes = [String:Int]()
    let maxNumberOfPhotosToDisplay = 10 //0 for unlimited

    //MARK: Outlets and Actions

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!

    @IBOutlet weak var categoryNameLable: UILabel!

    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var currentPhotoImageView: UIImageView!

    @IBAction func checkMarkTapped(_ sender: UIButton) {
        //guard let currentPhotoOwner = self.currentPhoto.businessAlias else { return }

        let businessDescribedByPhoto = photoArray[photoIndex].businessId
        updateLikes(for: businessDescribedByPhoto)

    }

    @IBAction func discardTapped(_ sender: UIButton) {

        displayNextStep()
    }

    //MARK: App cycle
    override func viewDidLoad() {
        super.viewDidLoad()


        getPhotosFromLocalBusinesses()

        guard let currentCategory = self.category else {
            return
        }
        categoryNameLable.text = currentCategory.title

        questionLabel.text = "What kind of \(currentCategory.title)?"


    }

    func updateLikes(for alias: String) {
        print("Updating likes for \(alias) by 1")
        

        self.likes[alias]! += 1
        print(likes)
        
        displayNextStep()
        
    }

    func calculateBestPlace() {
        guard let presentBusinesses = businesses else { return }
        guard let firstBusiness = likes.keys.first else { return }
        guard let firstBusinessVotes = likes[firstBusiness] else { return }

        var topBusiness = firstBusiness
        var topLikes = firstBusinessVotes

        for (businessAlias, numberOfLikes) in likes {

            if numberOfLikes == topLikes {

                print("ex aequo, do something else")

            } else if numberOfLikes > topLikes {

                topLikes = numberOfLikes
                topBusiness = businessAlias
                print("\(businessAlias) is more popular than \(topBusiness) ( \(numberOfLikes) vs \(topLikes)  )")

            } else {

                print("\(businessAlias) is NOT more popular than \(topBusiness) ( \(numberOfLikes) vs \(topLikes)  )")

            }

        }

        print("🏆 The most popular business is \(topBusiness)!")

        if let i = presentBusinesses.index(where: {$0.id == topBusiness}) {

            displayBusiness(business: presentBusinesses[i])

        }

    }

    func displayNextStep() {
        
        let numberOfPhotos = photoArray.count
        
        if maxNumberOfPhotosToDisplay == 0 {
            
            if photoIndex < numberOfPhotos - 1 {
                showNextImage()
            } else {
                print("🚀 Calculating prefered place then redirecting! ")
                calculateBestPlace()
            }
            
        } else {
            
            if photoIndex < numberOfPhotos - 1 && photoIndex < maxNumberOfPhotosToDisplay {
                showNextImage()
            } else {
                print("🚀 Calculating prefered place then redirecting! ")
                calculateBestPlace()
            }
        }

    }

    func showNextImage() {
        print("Showing next image...")
        self.photoIndex += 1

        let animation = {
            self.currentPhotoImageView.image = self.photoArray[self.photoIndex].image
        }

        UIView.transition(with: self.currentPhotoImageView, duration: 0.8, options: .transitionCrossDissolve, animations: animation, completion: nil)

    }

    func getPhotosFromLocalBusinesses() {
        //var arrayOfPhotos: [UIImage] = []
        print("Getting businesses ....")

        print("For each business, 📷 getting photos ....")
        //activitySpinner.startAnimating()


        async.addOperation {


            guard let currentCategory = self.category else { return }

            if let currentLocation = self.userLocation {
                print(currentCategory.alias)
                print(currentLocation)

                Business.getLocalPlaces(forCategory: currentCategory.alias, coordinates: currentLocation, completionHandler: { (businesses) in

                    self.main.addOperation {
                        self.businesses = businesses
                    }

                    for business in businesses {

                        //add alias to dictionary
                        self.likes[business.id] = 0

                        business.getPhotos(completionHandler: { (photosUrls) in

                            for photoUrl in photosUrls {
                                print("Photo URL: \(photoUrl)")

                                Business.getImageAsync(from: photoUrl, completionHandler: { (image) in

                                    self.main.addOperation {

                                        let photo = Photo(image: image, businessId: business.id)
                                        self.photoArray.append(photo)

                                        print(photo)
                                        //move this to view init, when photoarray has at least one image
                                        let animation = {
                                            self.currentPhotoImageView.image = self.photoArray[0].image
                                        }

                                        UIView.transition(with: self.currentPhotoImageView, duration: 0.8, options: .transitionCrossDissolve, animations: animation, completion: nil)

                                    }

                                })



                            }


                        })



                    }

                })


            }
            
        }

        
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
