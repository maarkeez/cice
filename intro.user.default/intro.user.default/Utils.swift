//
//  Utils.swift
//  intro.user.default
//
//  Created by cice on 27/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//
import UIKit
import Foundation

//MARK: - VariablesGlobales
//Variables globales
var prefs = UserDefaults.standard


let CONSTANTES = Constantes()

struct Constantes {
    let NOMBRE = "nombre"
    let APELLIDO = "apellido"
    let TELEFONO = "telefono"
    let DIRECCION = "direccion"
    let IMAGEN_DATA = "imagenData"
    let FECHA_ACTUALIZACION = "fechaActualizacion"
}

func getPopUp(titulo : String, mensaje : String, mensajeBoton:String) -> UIAlertController {
    let popUp =  UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
    popUp.addAction(UIAlertAction(title: mensajeBoton, style: .default, handler: nil))
    return popUp
}

func DateToString(date : Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateString = dateFormatter.string(from: date)
    return dateString
    
}
