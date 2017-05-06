//
//  DMDCocheModel.swift
//  AppTestTableView2
//
//  Created by cice on 13/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDCocheModel: NSObject {
    //Declaración de variables del modelo
    var nombre : String?
    var color : String?
    var imagenCoche : UIImage?
    
    init(nombre : String, color: String, imagenCoche: UIImage) {
        self.nombre = nombre
        self.color = color
        self.imagenCoche = imagenCoche
        super.init()
    }

}
