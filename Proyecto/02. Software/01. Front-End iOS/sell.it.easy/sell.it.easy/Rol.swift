//
//  Rol.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 31/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

@objc(Rol)
class Rol : NSObject {
    var id : String = ""
    var nombre : String = ""
    
    override init(){
        super.init()
    }
    
    init(id: String, nombre: String) {
        self.id = id
        self.nombre = nombre
    }
 
}
