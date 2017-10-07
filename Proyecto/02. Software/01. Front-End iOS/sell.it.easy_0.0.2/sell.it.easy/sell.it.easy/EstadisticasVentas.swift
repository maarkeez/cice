//
//  EstadisticasVentas.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 7/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

class EstadisticasVentas : Mappable {
    var horas = [Int]()
    var dineroHoras = [Double]()
    var nombreVendedores = [String]()
    var porcentajeVendedores = [Double]()
    
    init(horas : [Int], dineroHoras : [Double], nombreVendedores : [String], porcentajeVendedores : [Double]){
        self.horas = horas
        self.dineroHoras = dineroHoras
        self.nombreVendedores = nombreVendedores
        self.porcentajeVendedores = porcentajeVendedores
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        horas <- map["horas"]
        dineroHoras <- map["dineroHoras"]
        nombreVendedores <- map["nombreVendedores"]
        porcentajeVendedores <- map["porcentajeVendedores"]
    }
}
