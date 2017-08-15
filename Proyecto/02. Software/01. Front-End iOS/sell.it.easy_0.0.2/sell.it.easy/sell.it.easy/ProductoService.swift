//
//  ProductoService.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import ObjectMapper
import SwiftyJSON
import Alamofire

class ProductoService  {
    
    static let shared = ProductoService()
    
    let URL_ORGANIZACION = CONSTANTES.URL_BASE.URL_BASE + CONSTANTES.URL_BASE.PUERTO + "producto/"
    
    func alta(_ objeto : Producto, callback:@escaping (Producto?) -> Void){
        let URL_ALTA = URL_ORGANIZACION + "alta"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: objeto) { (json) in
            let obj = Producto(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func editar(_ objeto : Producto, callback:@escaping (Producto?) -> Void){
        let URL_ALTA = URL_ORGANIZACION + "\(objeto.id!)" + "/editar"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: objeto) { (json) in
            let obj = Producto(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func todos(callback:@escaping ([Producto]) -> Void){
        let URL_ALTA = URL_ORGANIZACION + "todos"
        
        ServiceUtils.shared.get(URL_ALTA) { (json) in
            
            var tiendas = [Producto]()
            
            for (_, object) in json {
                let obj = Producto(JSONString: object.rawString()!)
                tiendas.append(obj!)
            }
            
            callback(tiendas)
        }
    }
}
