//
//  DMDCeldaTextoLargo.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

import UIKit

class DMDCeldaTextoLargo: DMDCeldaCGDelegate{
    
    var titulo : String
    var texto : String
    var seleccionable : Bool = true
    func isSeleccionable() -> Bool {
        return seleccionable
    }

    init(nombre: String, texto: String) {
        self.titulo = nombre
        self.texto = texto
    }
    
    func getAltura() -> CGFloat{
        return 75
        
    }
    
    func setIBOutlets(_ celda: UITableViewCell) {
        let myTitulo = celda.viewWithTag(1) as! UILabel
        let myTexto = celda.viewWithTag(2) as! UILabel
        myTitulo.text = titulo
        myTexto.text = texto
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "CeldaTextoLargo")
        setIBOutlets(celda!)
        return celda!
    }
    
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    
    func getTipo() -> Int {
        return CELDA_TIPOS.TEXTO_LARGO
    }
    
}
