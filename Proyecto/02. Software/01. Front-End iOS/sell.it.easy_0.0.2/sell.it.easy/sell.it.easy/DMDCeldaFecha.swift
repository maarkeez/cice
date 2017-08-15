//
//  DMDCeldaFecha.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDCeldaFecha: DMDCeldaCGDelegate{
    
    var texto : String
    var fecha : Date
    var seleccionable : Bool = true
    func isSeleccionable() -> Bool {
        return seleccionable
    }

    
    init(texto: String, fecha : Date) {
        self.fecha = fecha
        self.texto = texto
    }
    
    func getAltura() -> CGFloat{
        return 44
        
    }
    
    func setIBOutlets(_ celda: UITableViewCell){
        let myTexto = celda.viewWithTag(1) as! UILabel
        let myFecha = celda.viewWithTag(2) as! UILabel
        let myHora = celda.viewWithTag(3) as! UILabel
        
        myTexto.text  = texto
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        myFecha.text = dateFormatter.string(from: fecha)
        dateFormatter.dateFormat = "HH:mm"
        myHora.text = dateFormatter.string(from: fecha)
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "CeldaFecha")
        setIBOutlets(celda!)
        return celda!
    }
    
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    
    func getTipo() -> Int {
        return CELDA_TIPOS.FECHA
    }
    
}
