//
//  Usuario.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class Usuario {
    var id : Int?
    var correo : String?
    var nombre : String?
    var apellidos : String?
    var password : String?
    var imagen : UIImage?
    
   init(id: Int?, correo: String?, nombre: String?, apellidos: String?, password: String?, imagen: UIImage?) {
        self.id = id
        self.correo = correo
        self.nombre = nombre
        self.apellidos = apellidos
        self.password = password
        self.imagen = imagen
    }
}
