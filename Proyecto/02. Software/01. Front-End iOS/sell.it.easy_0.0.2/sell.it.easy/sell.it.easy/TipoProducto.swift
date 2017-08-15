//
//  TipoProducto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper


class TipoProducto : Mappable{

    var id : Int?
    var nombre : String!
    
    init(id: Int?, nombre: String!) {
        self.id = id
        self.nombre = nombre
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        nombre <- map["nombre"]
    }
}
