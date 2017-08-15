//
//  Rol.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

class Rol : Mappable {
    var id : String?
    var nombre : String?
    
    init(id: String?,  nombre: String?) {
        self.id = id
        self.nombre = nombre
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        nombre <- map["nombre"]
    }
}
