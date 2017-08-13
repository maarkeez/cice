//
//  listadoProductoCelda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class listadoProductoCelda: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myPrecio: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setIBOutlets(_ producto: Producto){
        
        if let imagenData = producto.imagen {
            myImagen.image =  UIImage(data: imagenData as Data)
        }
        
        if let nombre = producto.nombre {
            myNombre.text = nombre

        }
        
        
        
        myPrecio.text = "\(producto.pvp)"
        
        
    }
    
}
