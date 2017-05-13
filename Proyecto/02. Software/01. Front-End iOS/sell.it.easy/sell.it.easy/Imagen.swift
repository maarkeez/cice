//
//  Imagen.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 31/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//
import UIKit
import Foundation

@objc(Imagen)
class Imagen : NSObject{
    var id : Int = 0
    var url : String = ""
    var imagenUI : UIImage? {
        get {
            
            if let urlAux =  URL(string: CONSTANTES.CONFIGURACION_WS.URL_CONEXION + url) {
                do{
                    print("Recuperando imagen.")
                    let data = try Data(contentsOf: urlAux)
                    return UIImage(data: data)
                }catch{
                }
            }
            return nil
        }
        set{}
    }
    
    override init(){
        super.init()
    }
}
