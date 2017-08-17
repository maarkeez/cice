//
//  CompraOnline.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 17/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

class CompraOnline : Mappable {
    var id : Int?
    var fecha: Date!
    var comprador : Usuario?
    var pedido : Pedido?
    
    init(id: Int?, fecha: Date!, comprador: Usuario?, pedido: Pedido?) {
        self.id = id
        self.fecha = fecha
        self.comprador = comprador
        self.pedido = pedido
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        fecha <- (map["fecha"],DateTransformCustom())
        comprador <- map["comprador"]
        pedido <- map["pedido"]
    }
}
