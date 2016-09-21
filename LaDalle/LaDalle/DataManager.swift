//
//  DataManager.swift
//  LaDalle
//
//  Created by Loris Mazloum on 9/20/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

class DataManager {
    var businesses: [Business] = []
    var categories: [Category] = []
    
    static let sharedInstance = DataManager()
    
    private init() {
    
    }
    
}
