//
//  ImportHelper.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import UIKit

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
