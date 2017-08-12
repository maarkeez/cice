//
//  DMDCeldaPerfil.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 12/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDCeldaPerfil: DMDCeldaCGDelegate{
    
    var imagen : UIImage?
    var nombre : String?
    var fondo : UIImage?
    
    
    init(imagen: UIImage, nombre: String, fondo: UIImage) {
        self.imagen = imagen
        self.nombre = nombre
        self.fondo = fondo
    }
    
    func setIBOutlets(_ celda: UITableViewCell){
        
        let name = celda.viewWithTag(1) as! UILabel
        let background = celda.viewWithTag(2) as! UIImageView
        let profileImage = celda.viewWithTag(3) as! UIImageView

        name.text = nombre
        background.image = fondo
        profileImage.image = imagen
        
    }
    
    func getAltura() -> CGFloat{
        return 350
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "CeldaPerfil")!
        setIBOutlets(celda)
        return celda
    }
    
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    func getTipo() -> Int{
        return CELDA_TIPOS.PERFIL
    }
}
