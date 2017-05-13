//
//  Organizacion.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 31/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class Organizacion {
    var id : Int = 0
    var CIF : String = ""
    var nombre : String = ""
    var direccionFiscal : String = ""
    var tiendas : [Tienda] = []
    var imagen : Imagen = Imagen()
    var tipoProducto : TipoProducto = TipoProducto()
    var telefono : String = ""
    
    
}
