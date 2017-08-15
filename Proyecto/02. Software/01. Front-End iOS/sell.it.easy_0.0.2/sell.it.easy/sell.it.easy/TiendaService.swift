//
//  TiendaService.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import ObjectMapper
import SwiftyJSON
import Alamofire

class TiendaService  {
    
    static let shared = TiendaService()
    
    let URL_ORGANIZACION = CONSTANTES.URL_BASE.URL_BASE + CONSTANTES.URL_BASE.PUERTO + "tienda/"
    
    func alta(_ tienda : Tienda, callback:@escaping (Tienda?) -> Void){
        let URL_ALTA = URL_ORGANIZACION + "alta"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: tienda) { (json) in
            let obj = Tienda(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func editar(_ tienda : Tienda, callback:@escaping (Tienda?) -> Void){
        let URL_ALTA = URL_ORGANIZACION + "\(tienda.id!)" + "/editar"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: tienda) { (json) in
            let obj = Tienda(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func todos(callback:@escaping ([Tienda]) -> Void){
        let URL_ALTA = URL_ORGANIZACION + "todos"
        
        ServiceUtils.shared.get(URL_ALTA) { (json) in
            
            var tiendas = [Tienda]()
            
            for (index, object) in json {
                let obj = Tienda(JSONString: object.rawString()!)
                tiendas.append(obj!)
            }
            
            callback(tiendas)
        }
    }
}
