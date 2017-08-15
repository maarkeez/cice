//
//  Organizacion.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import ObjectMapper

class Organizacion : Mappable {

    var id : Int!
    var CIF : String!
    var nombre : String!
    var direccionFiscal : String!
    var imagenString : String?
    // var tipoProducto : TipoProducto
    var telefono : String!
    
    init(id: Int, CIF: String, nombre: String, direccionFiscal: String, imagenString: String?, telefono: String) {
        self.id = id
        self.CIF = CIF
        self.nombre = nombre
        self.direccionFiscal = direccionFiscal
        self.imagenString = imagenString
        self.telefono = telefono
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        CIF <- map["CIF"]
        nombre <- map["nombre"]
        direccionFiscal <- map["direccionFiscal"]
        imagenString <- map["imagenString"]
        telefono <- map["telefono"]
    }
    
    
}
