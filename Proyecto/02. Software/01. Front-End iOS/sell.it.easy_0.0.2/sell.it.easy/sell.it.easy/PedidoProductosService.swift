//
//  PedidoProductosService.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 17/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import ObjectMapper
import SwiftyJSON
import Alamofire


class PedidoProductosService  {
    
    static let shared = PedidoProductosService()
    
    let URL_PEDIDO = CONSTANTES.URL_BASE.URL_BASE + CONSTANTES.URL_BASE.PUERTO + "pedidoproductos/"
    
    func alta(_ objeto : PedidoProductos, callback:@escaping (PedidoProductos?) -> Void){
        let URL_ALTA = URL_PEDIDO + "alta"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: objeto) { (json) in
            let obj = PedidoProductos(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    
    func editar(_ objeto : PedidoProductos, callback:@escaping (PedidoProductos?) -> Void){
        let URL_EDITAR = URL_PEDIDO + "\(objeto.id!)" + "/editar"
        
        ServiceUtils.shared.post(URL_EDITAR, parametros: objeto) { (json) in
            let obj = PedidoProductos(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func todos(callback:@escaping ([PedidoProductos]) -> Void){
        let URL_TODOS = URL_PEDIDO + "todos"
        
        ServiceUtils.shared.get(URL_TODOS) { (json) in
            
            var tiendas = [PedidoProductos]()
            
            for (_, object) in json {
                let obj = PedidoProductos(JSONString: object.rawString()!)
                tiendas.append(obj!)
            }
            
            callback(tiendas)
        }
    }
    
    func findByPedido_id(_ id: Int, callback:@escaping ([PedidoProductos]) -> Void){
        let URL_TODOS = URL_PEDIDO + "pedido/\(id)"
        print(URL_TODOS)
        
        ServiceUtils.shared.get(URL_TODOS) { (json) in
            
            var tiendas = [PedidoProductos]()
            
            for (_, object) in json {
                let obj = PedidoProductos(JSONString: object.rawString()!)
                tiendas.append(obj!)
            }
            
            callback(tiendas)
        }
    }
}
