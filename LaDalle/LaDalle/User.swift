//
//  User.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/22/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let imageUrl: String
    
    static func fromDictionary(dictionary: NSDictionary) -> User? {
        
        //Pull out each individual element from the dictionary
        guard
            let name = dictionary["name"] as? String,
            let imageUrl = dictionary["image_url"] as? String
            else {
                return nil
        }
        
        //Take the data parsed and create a Place Object from it
        return User(name: name, imageUrl: imageUrl)
    }
}
