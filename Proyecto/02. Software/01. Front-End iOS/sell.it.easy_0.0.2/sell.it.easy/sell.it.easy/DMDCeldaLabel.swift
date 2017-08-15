//
//  DMDCeldaLabel.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class DMDCeldaLabel : DMDCeldaCGDelegate{
    
    var nombre : String
    var texto : String
    
    init(nombre: String, texto: String) {
        self.nombre = nombre
        self.texto = texto
    }
    
    func getAltura() -> CGFloat{
        return 50
    }
    
    func setIBOutlets(_ celda: UITableViewCell) {
        let myNombre = celda.viewWithTag(1) as! UILabel
        let myValor = celda.viewWithTag(2) as! UILabel
        myNombre.text = nombre
        myValor.text = texto
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "CeldaLabel")
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