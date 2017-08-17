//
//  Pedido.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 17/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper


class Pedido : Mappable{

    var id : Int?
    var fechaApertura : Date!
    var fechaCierre : Date?
    var tipoPago : TipoPago?
    var tipoCompra : TipoCompra?
    var tienda : Tienda?
    
    init(id: Int?, fechaApertura: Date!, fechaCierre: Date?, tipoPago: TipoPago?, tipoCompra: TipoCompra?, tienda: Tienda?) {
        self.id = id
        self.fechaApertura = fechaApertura
        self.fechaCierre = fechaCierre
        self.tipoPago = tipoPago
        self.tipoCompra = tipoCompra
        self.tienda = tienda
    }
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        id <- map["id"]
        fechaApertura <- (map["fechaApertura"],DateTransformCustom())
        fechaCierre <- (map["fechaCierre"],DateTransformCustom())
        tipoPago <- map["tipoPago"]
        tipoCompra <- map["tipoCompra"]
        tienda <- map["tienda"]
    }
}
