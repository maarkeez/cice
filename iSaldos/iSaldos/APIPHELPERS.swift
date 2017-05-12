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
