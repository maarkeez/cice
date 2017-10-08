//
//  Tienda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

class Tienda : Mappable{
    var id : Int?
    var nombre : String!
    var imagenString : String?
    var telefono : String?
    var direccion : String?
    
    init(id: Int?, nombre: String, imagenString: String?, telefono: String?, direccion: String?) {
        self.id = id
        self.nombre = nombre
        self.imagenString = imagenString
        self.telefono = telefono
        self.direccion = direccion
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        nombre <- map["nombre"]
        imagenString <- map["imagenString"]
        telefono <- map["telefono"]
        direccion <- map["direccion"]
    }
   
}
