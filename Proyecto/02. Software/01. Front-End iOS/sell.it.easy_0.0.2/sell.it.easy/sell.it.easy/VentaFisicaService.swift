//
//  VentaFisicaService.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 17/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//
import ObjectMapper
import SwiftyJSON
import Alamofire


class VentaFisicaService  {
    
    static let shared = VentaFisicaService()
    
    let URL_VENTA_FISICA = CONSTANTES.URL_BASE.URL_BASE + CONSTANTES.URL_BASE.PUERTO + "ventafisica/"
    
    func alta(_ objeto : VentaFisica, callback:@escaping (VentaFisica?) -> Void){
        let URL_ALTA = URL_VENTA_FISICA + "alta"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: objeto) { (json) in
            let obj = VentaFisica(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func editar(_ objeto : VentaFisica, callback:@escaping (VentaFisica?) -> Void){
        let URL_ALTA = URL_VENTA_FISICA + "\(objeto.id!)" + "/editar"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: objeto) { (json) in
            let obj = VentaFisica(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func todos(callback:@escaping ([VentaFisica]) -> Void){
        let URL_ALTA = URL_VENTA_FISICA + "todos"
        
        ServiceUtils.shared.get(URL_ALTA) { (json) in
            
            var tiendas = [VentaFisica]()
            
            for (_, object) in json {
                let obj = VentaFisica(JSONString: object.rawString()!)
                tiendas.append(obj!)
            }
            
            callback(tiendas)
        }
    }
}
