//
//  ProtocoloAlta.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 4/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//
import UIKit
import Foundation

class DatosProtocoloAlta {
    var datos : [Any] = []
    var etiquetas : [Any] = []
    var imagen : UIImage?
    
    var lineas : Int  {
        var numeroDeLineas : Int = 0
        if (datos.count % 2 == 0){
            numeroDeLineas = datos.count / 2
        }else{
            numeroDeLineas = (datos.count / 2) + 1
        }
        
        return numeroDeLineas
    }
}

protocol ProtocoloAlta {
    func setDatosProtocoloAlta(datos: DatosProtocoloAlta)
}

