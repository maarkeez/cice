//
//  User.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation


class User {
    var id : Int?
    var name : String?
    var email : String?
    var address : Address?
    var phone : String?
    var website : String?
    var company : Company?
    
    init ( id : Int?,
           name : String?,
           email : String?,
           address : Address?,
           phone : String?,
           website : String?, 
           company : Company?
        
        ){
        
        self.id = id
        self.name = name
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
    }
    
}
