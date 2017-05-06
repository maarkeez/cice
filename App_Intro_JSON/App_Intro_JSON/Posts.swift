//
//  Posts.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation

class Posts {
    
    var userId : Int?
    var id : Int?
    var title : String?
    var body : String?
    
    init(userId : Int?, id: Int?, title: String?, body: String?){
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        
    }
    
}
