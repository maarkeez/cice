//
//  Poster.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
@objc(Poster)
class Poster : NSObject {
    var Title : String = ""
    var Year  : String = ""
    var imdbID : String  = ""
    var `Type` : String  = ""
    var Poster  : String = ""
    
    override init(){
        
        
    
        super.init()
    }

    init(Title: String, Year: String, imdbID: String, Type: String, Poster: String) {
        self.Title = Title
        self.Year = Year
        self.imdbID = imdbID
        self.Type = Type
        self.Poster = Poster
    }
    
}
