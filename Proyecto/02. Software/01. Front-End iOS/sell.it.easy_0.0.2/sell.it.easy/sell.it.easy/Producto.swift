//
//  Producto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation


class Producto {
    
    let id : Int?
    let nombre : String?
    let descripcion : String?
    let pvp : Float?
    let imagen : Data?
    
    
    init(id: Int?, nombre: String?, descripcion: String?, pvp: Float?, imagen: Data?) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.pvp = pvp
        self.imagen = imagen
    }
   
    
}
