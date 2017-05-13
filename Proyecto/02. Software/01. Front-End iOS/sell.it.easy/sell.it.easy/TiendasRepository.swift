//
//  TiendasRepository.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 4/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//
import UIKit
import Foundation
import SwiftyJSON
import CoreData

class TiendasRepository {
    
    static let shared = TiendasRepository()
    
    //MARK: - Funciones
    func findAll() -> [Tienda] {
        let url = URL(string: CONSTANTES.CONFIGURACION_WS.URL_CONEXION + "/tienda/todos")
        
        let postsData = NSData(contentsOf: url!)
        
        return retrieveTiendaFromData(dataFromNetwork: postsData!)
        
    }
    
    func retrieveTiendaFromData(dataFromNetwork : NSData) -> [Tienda]{
        // Array a devolver
        var tiendas : [Tienda] = []
        // JSON a partir de DATA
        let legibleJSON = JSON(data: dataFromNetwork as Data)
        
        //Convertir cada JSON al objeto
        for i in 0..<legibleJSON.count{
            let tiendaJSON = legibleJSON[i]
            
            var tienda = Tienda()
            let copiaInstancia = Mirror(reflecting: tienda)
            tienda = Parseador.shared.parse(with: copiaInstancia, from : tiendaJSON, to: tienda as NSObject) as! Tienda
            tiendas.append(tienda)
        }
        
        return tiendas
    }
}
