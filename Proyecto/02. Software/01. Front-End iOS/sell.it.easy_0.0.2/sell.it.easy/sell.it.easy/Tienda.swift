//
//  Tienda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class Tienda {
    let id : Int?
    let nombre : String?
    let imagen : Data?
    let telefono : String?
    
    init(id: Int?, nombre: String?, imagen: Data?, telefono: String?) {
        self.id = id
        self.nombre = nombre
        self.imagen = imagen
        self.telefono = telefono
    }
    // let organizacion
}
