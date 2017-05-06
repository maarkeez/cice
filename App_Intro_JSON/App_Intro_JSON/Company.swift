//
//  Company.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation

class Company {
    
    var name : String?
    var catchPhrase : String?
    var bs : String?
    
    init(
        name : String?,
        catchPhrase : String?,
        bs : String?
        ){
        
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
}
