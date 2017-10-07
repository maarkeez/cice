//
//  EstadisticasService.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 7/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import ObjectMapper
import SwiftyJSON
import Alamofire

class EstadisticasService  {
    
    static let shared = EstadisticasService()
    
    let URL_ESTADISTICAS = CONSTANTES.URL_BASE.URL_BASE + CONSTANTES.URL_BASE.PUERTO + "estadisticas/"
    
    func venta(idTienda : Int, fechaInicio : Date, fechaFin: Date, callback:@escaping (EstadisticasVentas?) -> Void){
        
        var URL_VENTA_TIENDA = URL_ESTADISTICAS + "venta/"
        URL_VENTA_TIENDA = URL_VENTA_TIENDA + "tienda/\(idTienda)/"
        URL_VENTA_TIENDA = URL_VENTA_TIENDA + "desde/\(fechaInicio.stringValueHTTP)/"
        URL_VENTA_TIENDA = URL_VENTA_TIENDA + "hasta/\(fechaFin.stringValueHTTP)"
        
        print("Recuperando datos desde: " + URL_VENTA_TIENDA)
        
        ServiceUtils.shared.get(URL_VENTA_TIENDA) { (json) in
            let obj = EstadisticasVentas(JSONString: json.rawString()!)
            callback(obj)
        }
    }
}
