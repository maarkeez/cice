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
    
    init(texto: String, fecha : Date) {
        self.fecha = fecha
        self.texto = texto
    }
    
    func getAltura() -> CGFloat{
        return 4
        
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "celdaFecha") as! celdaFecha
        celda.setIBOutlets(texto: texto, fecha: fecha)
        return celda
    }
    
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    
}
