//
//  Usuario.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 31/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

@objc(Usuario)
class Usuario : NSObject {
    var id : Int = 0
    var nombre : String = ""
    var apellidos : String = ""
    var correo : String = ""
    var password : String = ""
    var roles : [Rol]? = []
    var imagen : Imagen?
    
   
    override init(){
        super.init()
    }
    
    init(id: Int, nombre: String, apellidos: String, correo: String, password: String, roles: [Rol]?, imagen: Imagen?) {
        self.id = id
        self.nombre = nombre
        self.apellidos = apellidos
        self.correo = correo
        self.password = password
        self.roles = roles
        self.imagen = imagen
    }
    
    
   
}
