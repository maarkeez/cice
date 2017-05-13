//
//  ProductoBBDD.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 1/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class Producto {
    var id : Int = 0
    var nombre : String = ""
    var descripcion : String = ""
    var tipoProducto : TipoProducto = TipoProducto()
    var propiedades : PropiedadProducto = PropiedadProducto()
    
    
}
