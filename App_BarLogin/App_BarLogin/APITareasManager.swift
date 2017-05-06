//
//  APITareasManager.swift
//  App_BarLogin
//
//  Created by cice on 10/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation

///Cada instancia de esta clase, internamente apuntan siempre al mismo objeto
class APITareasManager{
    ///Singleton: Objeto compartido en toda la aplicacion
    static let shared = APITareasManager()
    
    var tareas : [Contacto] = []
    var fotoTarea : [Contacto] = []

    
    func guardarTareas () {
        preferencias.setValue(tareas, forKey: CONSTANTES.USER_DEFAULTS.KEY_TAREAS)
        preferencias.setValue(fotoTarea, forKey: CONSTANTES.USER_DEFAULTS.KEY_IMAGEN_TAREA)
    }
    
    func cargarDatosTareas() {
        if let myArrayTareas = preferencias.array(forKey: CONSTANTES.USER_DEFAULTS.KEY_TAREAS) as? [Contacto]{
            tareas = myArrayTareas
        }
        
        if let myArrayFotos = preferencias.array(forKey: CONSTANTES.USER_DEFAULTS.KEY_IMAGEN_TAREA) as? [Contacto]{
            fotoTarea = myArrayFotos
        }
    }
    
}
