//
//  StockService.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 8/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import ObjectMapper
import SwiftyJSON
import Alamofire

class StockService {
    
    
    static let shared = StockService()

    
    let URL_STOCK = CONSTANTES.URL_BASE.URL_BASE + CONSTANTES.URL_BASE.PUERTO + "stock/"
    
    func add(stock : Stock , callback:@escaping (Stock?) -> Void){
        let URL_ADD = URL_STOCK + "add"
        
        ServiceUtils.shared.post(URL_ADD, parametros: stock) { (json) in
            let obj = Stock(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func edit(stock : Stock, callback:@escaping (Stock?) -> Void){
        let URL_EDITAR = URL_STOCK + "edit"
        
        ServiceUtils.shared.post(URL_EDITAR, parametros: stock) { (json) in
            let obj = Stock(JSONString: json.rawString()!)
            callback(obj)
        }
    }
    
    func todos(_ idTienda : Int, callback:@escaping ([Stock]) -> Void){
        let URL_TODOS = URL_STOCK + "tienda/\(idTienda)"
        
        ServiceUtils.shared.get(URL_TODOS) { (json) in
            
            var stocks = [Stock]()
            
            for (_, object) in json {
                let obj = Stock(JSONString: object.rawString()!)
                stocks.append(obj!)
            }
            
            callback(stocks)
        }
    }
    
    
    
}
