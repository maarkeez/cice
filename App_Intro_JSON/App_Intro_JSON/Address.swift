//
//  Address.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation


class Address {
    var street : String?
    var suite : String?
    var city : String?
    var zipcode : String?
    var geo : Geo?
    
    init(
        street : String?,
        suite : String?,
        city : String?,
        zipcode : String?,
        geo : Geo?
        ){
        
        
        
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
        
    }
}

