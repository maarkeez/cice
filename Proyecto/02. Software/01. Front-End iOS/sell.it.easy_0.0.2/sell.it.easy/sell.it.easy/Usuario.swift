//
//  Usuario.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

class Usuario: Mappable {
    var id : Int?
    var correo : String?
    var nombre : String?
    var apellidos : String?
    var password : String?
    var imagenString : String?
    var roles = [Rol]()
    
   init(id: Int?, correo: String?, nombre: String?, apellidos: String?, password: String?, imagenString: String?) {
        self.id = id
        self.correo = correo
        self.nombre = nombre
        self.apellidos = apellidos
        self.password = password
        self.imagenString = imagenString
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        correo <- map["correo"]
        nombre <- map["nombre"]
        apellidos <- map["apellidos"]
        password <- map["password"]
        imagenString <- map["imagenString"]
        roles <- map["roles"]
    }
}
