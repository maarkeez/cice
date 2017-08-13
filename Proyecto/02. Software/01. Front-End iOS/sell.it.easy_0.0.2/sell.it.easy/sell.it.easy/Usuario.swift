//
//  Usuario.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class Usuario {
    let id : Int?
    let correo : String?
    let nombre : String?
    let apellidos : String?
    let password : String?
    let imagen : Data?
    
   init(id: Int?, correo: String?, nombre: String?, apellidos: String?, password: String?, imagen: Data?) {
        self.id = id
        self.correo = correo
        self.nombre = nombre
        self.apellidos = apellidos
        self.password = password
        self.imagen = imagen
    }
}
