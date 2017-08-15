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
    var seleccionable : Bool = true
    func isSeleccionable() -> Bool {
        return seleccionable
    }

    init(nombre: String, texto: String) {
        self.nombre = nombre
        self.texto = texto
    }
    
    func getAltura() -> CGFloat{
        return 50
        
    }
    
    func setIBOutlets(_ celda: UITableViewCell) {
        let myNombre = celda.viewWithTag(1) as! UILabel
        let myValor = celda.viewWithTag(2) as! UITextField
        myNombre.text = nombre
        myValor.text = texto
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "CeldaTexto")
        setIBOutlets(celda!)
        return celda!
    }
    
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    
    func getTipo() -> Int {
        return CELDA_TIPOS.TEXTO_CORTO
    }
    
}
