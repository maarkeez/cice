//
//  MovieModel.swift
//  App_iMDb
//
//  Created by cice on 28/4/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation

class MovieModel {
    
    var id : String?
    var title : String?
    var order : Int?
    var summary : String?
    var image : String?
    var category : String?
    var director : String?
    
    init(id: String?, title: String?, order: Int?, summary: String?, image: String?, category: String?, director: String?){
        self.id = id
        self.title = title
        self.order = order
        self.summary = summary
        self.image = image
        self.director = director
        self.category = category
    }
    
}
