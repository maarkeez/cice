//
//  PedidoService.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 17/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import ObjectMapper
import SwiftyJSON
import Alamofire


class PedidoService  {
    
    static let shared = PedidoService()
    
    let URL_PEDIDO = CONSTANTES.URL_BASE.URL_BASE + CONSTANTES.URL_BASE.PUERTO + "pedido/"
    
    func alta(_ objeto : Pedido, callback:@escaping (Pedido?) -> Void){
        let URL_ALTA = URL_PEDIDO + "alta"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: objeto) { (json) in
            let obj = Pedido(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func editar(_ objeto : Pedido, callback:@escaping (Pedido?) -> Void){
        let URL_EDITAR = URL_PEDIDO + "\(objeto.id!)" + "/editar"
        
        ServiceUtils.shared.post(URL_EDITAR, parametros: objeto) { (json) in
            let obj = Pedido(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func todos(callback:@escaping ([Pedido]) -> Void){
        let URL_TODOS = URL_PEDIDO + "todos"
        
        ServiceUtils.shared.get(URL_TODOS) { (json) in
            
            var tiendas = [Pedido]()
            
            for (_, object) in json {
                let obj = Pedido(JSONString: object.rawString()!)
                tiendas.append(obj!)
            }
            
            callback(tiendas)
        }
    }
}
