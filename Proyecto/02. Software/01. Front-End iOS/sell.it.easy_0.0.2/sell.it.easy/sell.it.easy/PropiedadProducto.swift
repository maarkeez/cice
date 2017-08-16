//
//  PropiedadProducto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper


class PropiedadProducto : Mappable{

    var id : Int?
    var talla : String?
    var codigoDeBarras : String?
    var codigoDeEmpresa : String?
    var precioCoste : Float?
    var precioVentaPublico : Float?
    var descuento : Float?
    var imagenString : String?
    var IVA : Float?
    
    init(id: Int?, talla: String?, codigoDeBarras: String?, codigoDeEmpresa: String?, precioCoste: Float?, precioVentaPublico: Float?, descuento: Float?, imagenString: String?, IVA: Float?) {
        self.id = id
        self.talla = talla
        self.codigoDeBarras = codigoDeBarras
        self.codigoDeEmpresa = codigoDeEmpresa
        self.precioCoste = precioCoste
        self.precioVentaPublico = precioVentaPublico
        self.descuento = descuento
        self.imagenString = imagenString
        self.IVA = IVA
    }
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        id <- map["id"]
        talla <- map["talla"]
        codigoDeBarras <- map["codigoDeBarras"]
        codigoDeEmpresa <- map["codigoDeEmpresa"]
        precioCoste <- map["precioCoste"]
        precioVentaPublico <- map["precioVentaPublico"]
        descuento <- map["descuento"]
        imagenString <- map["imagenString"]
        IVA <- map["iva"]
    }
}
