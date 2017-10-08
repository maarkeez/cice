//
//  DMDCeldaMapa.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 8/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDCeldaMapa: DMDCeldaCGDelegate{
    
    var texto : String
    var seleccionable : Bool = true
    
    func isSeleccionable() -> Bool {
        return seleccionable
    }
    
    
    init(texto: String) {
        self.texto = texto
    }
    
    func getAltura() -> CGFloat{
        return 44
        
    }
    
    func setIBOutlets(_ celda: UITableViewCell){
        let myDesc = celda.viewWithTag(1) as! UILabel
        let myDireccion = celda.viewWithTag(2) as! UILabel
        
        myDesc.text  = "Dirección"
        myDireccion.text = texto
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "CeldaMapa")
        setIBOutlets(celda!)
        return celda!
    }
    
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    
    func getTipo() -> Int {
        return CELDA_TIPOS.MAPA
    }
    
}
