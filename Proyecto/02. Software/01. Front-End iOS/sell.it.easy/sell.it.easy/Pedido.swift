//
//  Pedido.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 1/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class Pedido {
    var id : Int = 0
    var fechaApertura : Date = Date()
    var fechaCierre : Date  = Date()
    var tipoPago : TipoPago = TipoPago()
    var tipoCompra : TipoCompra = TipoCompra()
    var productos : [PedidoProductos] = []
    var tienda : Tienda = Tienda()
    
}
