//
//  MovieManagerMapping.swift
//  App_iMDb
//
//  Created by cice on 28/4/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation
import CoreData


extension MovieManager{
    
    ///Para cualquier objeto MovieManager, permite recuperar un MovieModel
    func mappedObj() -> MovieModel{
        return MovieModel(id: self.id!, title: self.title!, order: Int(self.order), summary: self.summary!, image: self.image!, category: self.category!, director: self.director!)
    }
}
