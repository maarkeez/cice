//
//  ImportHelper.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

//MARK: - Utils para LIFE VC

///Devuelve un alert a partir de los parámetros introducidos. Sólo muestra una acción y no llama a ningún callback
/// - parameter titulo: Titulo de la alerta
/// - parameter mensaje: Mensaje a mostrar en el alert
/// - paramater tituloAccion: título de la acción que se puede realizar en el alert
func showAlert(_ titulo: String, mensaje: String, tituloAccion: String) -> UIAlertController {
    let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: tituloAccion, style: .default, handler: nil))
    return alert
}

//MARK: - Métodos para tratar la política de nulos.

///Obtener string a partir de una propiedad del JSON.
/// - parameter json: Json de entrada
/// - parameter key: clave para el JSON
/// - returns: Devuelve una cadena vacía "" en caso de no encontrar nada
func getString(_ json: JSON, key: String) -> String {
    if let stringResult = json[key].string {
        return stringResult
    }
    return ""
}

///Obtener Int a partir de una propiedad del JSON.
/// - parameter json: Json de entrada
/// - parameter key: clave para el JSON
/// - returns: Devuelve 0 en caso de no encontrar nada
func getInt(_ json: JSON, key: String) -> Int {
    if let intResult = json[key].int {
        return intResult
    }
    return 0
}

///Obtener Float a partir de una propiedad del JSON.
/// - parameter json: Json de entrada
/// - parameter key: clave para el JSON
/// - returns: Devuelve 0.0 en caso de no encontrar nada
func getFloat(_ json: JSON, key: String) -> Float {
    if let floatResult = json[key].float {
        return floatResult
    }
    return 0.0
}

///Obtener string a partir de una propiedad del JSON.
/// - parameter json: Json de entrada
/// - parameter key: clave para el JSON
/// - returns: Devuelve 0.0 en caso de no encontrar nada
func getInt(_ json: JSON, key: String) -> Double {
    if let doubleResult = json[key].double {
        return doubleResult
    }
    return 0.0
}
