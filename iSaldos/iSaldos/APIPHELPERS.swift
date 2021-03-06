//
//  APIPHELPERS.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON
import MessageUI

let customPrefs = UserDefaults.standard

///Devuelve un alertVC con el título y el mensaje especificado
func muestraAlertVC(_ titleData : String, messageData: String) -> UIAlertController{
    let alertVC = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alertVC
}

///Permite abrir la aplicación de mails con un email predefinido
func configureMailCompose() -> MFMailComposeViewController {
    let mailCompose = MFMailComposeViewController()
    mailCompose.setToRecipients([""])
    mailCompose.setSubject("Ayuda para saber más sobre la App")
    mailCompose.setMessageBody("Escriba por favor un corto mensaje al equipo de soporte de la App.", isHTML: false)
    return mailCompose
}

///Convierte a String el campo con la clave "nombre" para el JSON introducido
func dimeString(_ json: JSON, nombre: String) -> String {
    if let stringResult = json[nombre].string {
        return stringResult
    }else{
        return ""
    }
}

///Devuelve un string con la URL a la imagen
func getImagePath(_ type: String, id: String, name: String) -> String {
    return CONSTANTES.LLAMADAS.BASE_URL_FOTO + id + "/" + name
    
}

func formatDate(_ fecha: String? ) -> String{
    if let fecha = fecha {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        dateFormatter.locale = Locale.init(identifier: "es_ES")
        
        let dateObj = dateFormatter.date(from: fecha)
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: dateObj!)
    }
    return ""
}
