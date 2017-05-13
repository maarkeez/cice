//
//  Inventario.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 4/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class Inventario {
    var id : Int = 0
    var fechaInicio : Date = Date()
    var fechaFin : Date = Date()
    var completo : Bool = true
    var productosInventariados : [PedidoProductos] = []
    var tiendaInventariada : Tienda = Tienda()
    
}
