//
//  CeldaPerfil.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 16/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class CeldaPerfil : UITableViewCell{

    var imagen : UIImage?
    var nombre : String?
    var fondo : UIImage?
    
    
    init(imagen: UIImage, nombre: String, fondo: UIImage) {
        self.imagen = imagen
        self.nombre = nombre
        self.fondo = fondo
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setIBOutlets(imagen : UIImage, nombre: String, fondo: UIImage){
        
        var profileImage = viewWithTag(0) as! UIImageView
        var name = viewWithTag(1) as! UILabel
        var background = viewWithTag(2) as! UIImageView
        
        profileImage.image = imagen
        name.text = nombre
        background.image = fondo
        
        
    }
    
}

extension CeldaPerfil : DMDCeldaCGDelegate{
    func getAltura() -> CGFloat{
        return 350
    }
    
    func getCelda(_ tabla: UITableView) -> UITableViewCell{
        let celda = tabla.dequeueReusableCell(withIdentifier: "CeldaPerfil")!
        celda.setIBOutlets(imagen: <#T##UIImage#>, nombre: <#T##String#>, fondo: <#T##UIImage#>)
        return celda
    }
    
    func getAcciones() -> [UITableViewRowAction]?{
        return nil
    }
    func getTipo() -> Int{
        return CELDA_TIPOS.PERFIL
    }
}
