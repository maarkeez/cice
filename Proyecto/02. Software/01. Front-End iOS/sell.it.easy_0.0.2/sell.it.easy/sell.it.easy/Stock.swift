//
//  Stock.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 8/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

class Stock : Mappable {

    var id : Int?
    var tienda : Tienda!
    var producto : Producto!
    var cantidad : Int!
    
    
    init(id: Int?, tienda: Tienda!, producto: Producto!, cantidad: Int!) {
        self.id = id
        self.tienda = tienda
        self.producto = producto
        self.cantidad = cantidad
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        tienda <- map["tienda"]
        producto <- map["producto"]
        cantidad <- map["cantidad"]
    }
    
}
