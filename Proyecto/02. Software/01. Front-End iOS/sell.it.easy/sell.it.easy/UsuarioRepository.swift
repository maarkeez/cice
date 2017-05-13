//
//  UsuarioRepository.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 6/3/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import SwiftyJSON

class UsuarioRepository {
    
    //MARK: - Variables locales
    
    
    //MARK: - SINGLETON
    static let shared = UsuarioRepository()
    
    //MARK: - Funciones
    func findAll() -> [Usuario] {
        let url = URL(string: CONSTANTES.CONFIGURACION_WS.URL_CONEXION + "/usuario/todos")
        
        let postsData = NSData(contentsOf: url!)
        
        return retrieveUserFromData(dataFromNetwork: postsData!)
        
    }
    
    func retrieveUserFromData(dataFromNetwork : NSData) -> [Usuario]{
        // Array a devolver con los usuarios
        var usuarios : [Usuario] = []
        // JSON a partir de DATA
        let legibleJSON = JSON(data: dataFromNetwork as Data)

        //Convertir cada JSON a Usuario
        for i in 0..<legibleJSON.count{
            let usuarioJSON = legibleJSON[i]
            
            var usuario = Usuario()
            let copiaInstancia = Mirror(reflecting: usuario)
            usuario = Parseador.shared.parse(with: copiaInstancia, from : usuarioJSON, to: usuario as NSObject) as! Usuario
            usuarios.append(usuario)
        }
       
        return usuarios
    }
    
    
    
    
}
