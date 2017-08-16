//
//  Producto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper


class Producto : Mappable{
    var id : Int?
    var nombre : String!
    var descripcion : String!
    var tipoProducto : TipoProducto?
    var propiedades : PropiedadProducto?
    
    init(id: Int?, nombre: String!, descripcion: String!, tipoProducto: TipoProducto?, propiedades: PropiedadProducto?) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.tipoProducto = tipoProducto
        self.propiedades = propiedades
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        nombre <- map["nombre"]
        descripcion <- map["descripcion"]
        tipoProducto <- map["tipoProducto"]
        propiedades <- map["propiedades"]
    }
}
