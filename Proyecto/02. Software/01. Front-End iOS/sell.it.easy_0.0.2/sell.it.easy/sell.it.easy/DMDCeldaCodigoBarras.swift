//
//  DMDCeldaCodigoBarras.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 12/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//


import UIKit

class DMDCeldaCodigoBarras: DMDCeldaCGDelegate{
    
    var codigoBarras : String?
    var label : String = "Código de barras"
    
    var seleccionable : Bool = true
    func isSeleccionable() -> Bool {
        return seleccionable
    }
    
    init(codigoBarras: String) {
        self.codigoBarras = codigoBarras
    }
    
    init(_ label: String, codigoBarras: String) {
        self.codigoBarras = codigoBarras
        self.label = label
    }
    
    func setIBOutlets(_ celda: UITableViewCell){
        
        let codigo = celda.viewWithTag(1) as! UILabel
        let myLabel = celda.viewWithTag(2) as! UILabel
        codigo.text = codigoBarras
        myLabel.text = label
        
    }
    
    func getAltura() -> CGFloat{
        return 65
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "CeldaCodigoBarras")!
        setIBOutlets(celda)
        return celda
    }
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    func getTipo() -> Int{
        return CELDA_TIPOS.CODIGO_BARRAS
    }
    
    

}
