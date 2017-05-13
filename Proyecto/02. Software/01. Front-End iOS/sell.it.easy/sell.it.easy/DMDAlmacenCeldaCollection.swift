//
//  DMDAlmacenCeldaCollection.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 12/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDAlmacenCeldaCollection: UICollectionViewCell {

    //MARK: - Variables locales
    var producto : Producto = Producto()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myPrecio: UILabel!
    
    //MARK: - Life VC
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    func setIBOutlets(producto : Producto){
        self.producto = producto
        myImagen.image = producto.propiedades.imagen.imagenUI
        myNombre.text = producto.nombre
        myPrecio.text = "\(producto.propiedades.precioVentaPublico) €"
    }
}
