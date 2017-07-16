//
//  DMDCeldaTexto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDCeldaTexto: DMDCeldaCGDelegate{
    
    var nombre : String
    var texto : String
    
    init(nombre: String, texto: String) {
        self.nombre = nombre
        self.texto = texto
    }
    
    func getAltura() -> CGFloat{
        return 75
        
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "celdaTexto") as! celdaTexto
        celda.setIBOutlets(nombre: nombre, valor: texto)
        return celda
    }
    
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    
    func getTipo() -> Int {
        return CELDA_TIPOS.TEXTO_CORTO
    }
    
}
