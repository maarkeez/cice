//
//  Inventario.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 17/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

class Inventario : Mappable{

    var id : Int?
    var fechaInicio : Date?
    var fechaFin : Date?
    var completo : Bool!
    var tiendaInventariada  : Tienda?
    
    init(id: Int?, fechaInicio: Date?, fechaFin: Date?, completo: Bool!, tiendaInventariada: Tienda?) {
        self.id = id
        self.fechaInicio = fechaInicio
        self.fechaFin = fechaFin
        self.completo = completo
        self.tiendaInventariada = tiendaInventariada
    }
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        fechaInicio <- (map["fechaInicio"],DateTransformCustom())
        fechaFin <- (map["fechaFin"],DateTransformCustom())
        completo <- map["completo"]
        tiendaInventariada <- map["tiendaInventariada"]
    }
}
