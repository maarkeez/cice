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
    
    
    init(codigoBarras: String) {
        self.codigoBarras = codigoBarras
    }
    
    func setIBOutlets(_ celda: UITableViewCell){
        
        let codigo = celda.viewWithTag(1) as! UITextField
        codigo.text = codigoBarras
        
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
