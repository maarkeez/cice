//
//  Utils.swift
//  App_BarLogin
//
//  Created by cice on 3/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//
import UIKit
import Foundation

//MARK: - Variables Globales
let CONSTANTES = Constantes()
let tareasManager = APITareasManager.shared
let preferencias = UserDefaults.standard

//MARK: - Clases
typealias Contacto = [String : Any]


struct Constantes {
    let COLOR = Colores()
    let USER_DEFAULTS = UserDefaultsCustom()
}

struct Colores {
    let NEGRO = UIColor.black
    let AMARILLO = #colorLiteral(red: 0.9445604682, green: 0.7702477574, blue: 0.05788103491, alpha: 1)
    let CASI_NEGRO = #colorLiteral(red: 0.1027979776, green: 0.09788297862, blue: 0.09794340283, alpha: 1)
}

struct UserDefaultsCustom {
    let KEY_TAREAS = "tareas"
    let KEY_DESCRIPCION_TAREA = "descripcion"
    let KEY_ICONO_TAREA = "icono"
    let KEY_TITULO_ICONO_TAREA = "tituloIcono"
    let KEY_IMAGEN_TAREA = "imagen"
}


//MARK: - Funciones

//Función encargada de devolver un popup con un mensaje de alerta.
func getAlertVC(_ titulo : String, mensaje : String, tituloAccion : String) -> UIAlertController {
    
    let popUp = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert )
    popUp.addAction(UIAlertAction(title: tituloAccion, style: .default, handler: nil   ))
    return popUp
    
}

func muestraMiPerfilVCGlobal(navigationGlobal : UIViewController){
    //navigationGlobal.navigationController?.present( getAlertVC("Esta es otra VC", mensaje: "Bienvenido", tituloAccion: "OK Cierrate!"),animated: true,completion: nil)
    let perfilVC =  navigationGlobal.storyboard?.instantiateViewController(withIdentifier: "MiPerfil") as! DMDMiPerfil
    navigationGlobal.navigationController?.present(perfilVC, animated: true, completion: nil)
}


