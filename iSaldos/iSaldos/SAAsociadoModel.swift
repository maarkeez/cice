//
//  SAAsociadoModel.swift
//  iSaldos
//
//  Created by David Márquez Delgado on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAAsociadoModel: NSObject {
    
    
    
    var id : String?
    var nombre : String?
    var descripcion : String?
    var condicionesEspeciales : String?
    var direccion : String?
    var idActividad : String?
    var idLocalidad : String?
    var imagen : String?
    var telefonoFijo : String?
    var telefonoMovil : String?
    var mail : String?
    var web : String?
    
    init( id : String?,  nombre : String?, descripcion : String?, condicionesEspeciales : String?, direccion : String?,     idActividad : String?,     idLocalidad : String?,     imagen : String?,     telefonoFijo : String?,     telefonoMovil : String?,     mail : String?,     web : String?
        
        ){
        
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.condicionesEspeciales = condicionesEspeciales
        self.direccion = direccion
        self.idActividad = idActividad
        self.idLocalidad = idLocalidad
        self.imagen = imagen
        self.telefonoFijo = telefonoFijo
        self.telefonoMovil = telefonoMovil
        self.mail = mail
        self.web = web
        
    }
}
