//
//  Review.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/22/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

struct Review {
    let text: String
    let user: User
    let url: URL
    let rating: Double
    let timeCreated: String
    
    static func fromDictionary(dictionary: NSDictionary) -> Review? {
        
        //Pull out each individual element from the dictionary
        guard
            let text = dictionary["text"] as? String,
            let url = dictionary["url"] as? URL,
            let rating = dictionary["rating"] as? Double,
            let timeCreated = dictionary["time_created"] as? String
            else {
                return nil
        }
        
        //create user
        guard let userDictionary = dictionary["user"] as? NSDictionary else { return nil }
        guard let user = User.fromDictionary(dictionary: userDictionary) else {return nil}
        
        
        //Take the data parsed and create a Place Object from it
        return Review(text: text, user: user, url: url, rating: rating, timeCreated: timeCreated)
    }
}
