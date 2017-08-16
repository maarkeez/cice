//
//  VentaFisica.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 17/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

class VentaFisica : Mappable {
    var id : Int?
    var fecha: Date!
    var vendedor : Usuario?
    var pedido : Pedido?
    
    init(id: Int?, fecha: Date!, vendedor: Usuario?, pedido: Pedido?) {
        self.id = id
        self.fecha = fecha
        self.vendedor = vendedor
        self.pedido = pedido
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        fecha <- map["fecha"]
        vendedor <- map["vendedor"]
        pedido <- map["pedido"]
    }
}
