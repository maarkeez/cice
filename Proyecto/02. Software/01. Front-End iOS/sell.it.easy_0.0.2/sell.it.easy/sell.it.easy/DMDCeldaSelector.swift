//
//  DMDCeldaSelector.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDCeldaSelector: DMDCeldaCGDelegate {
    
    var titulo : String
    var indiceSeleccionado : Int
    var opciones : [String]
    var seleccionable : Bool = true
    func isSeleccionable() -> Bool {
        return seleccionable
    }

    init(titulo : String, indiceSeleccionado : Int, opciones: [String]) {
        self.titulo = titulo
        self.indiceSeleccionado = indiceSeleccionado
        self.opciones = opciones
    }
   
    func getAltura() -> CGFloat{
        return 50
    }
    
    func setIBOutlets(_ celda: UITableViewCell) {
        let myTitulo = celda.viewWithTag(1) as! UILabel
        let myValor = celda.viewWithTag(2) as! UILabel
        myTitulo.text = titulo
        myValor.text = opciones[indiceSeleccionado]
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "CeldaSelector")
        setIBOutlets(celda!)
        return celda!
    }
    
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    
    func getTipo() -> Int {
        return CELDA_TIPOS.SELECT
    }
}
