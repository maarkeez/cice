//
//  DMDAlmacenCelda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 21/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDAlmacenCelda: UITableViewCell {

    
    
    //MARK: - IBOutlets
    @IBOutlet weak var precioCoste: UILabel!
    @IBOutlet weak var precioPVP: UILabel!
    @IBOutlet weak var IVA: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var identificador: UILabel!

    
    //MARK: - Labels
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblIVA: UILabel!
    @IBOutlet weak var lblPrecioPVP: UILabel!
    @IBOutlet weak var lblPrecioCoste: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setIBOutlets(producto: Producto) {
        precioCoste.text = "\(producto.propiedades.precioCoste) €"
        precioPVP.text = "\(producto.propiedades.precioVentaPublico) €"
        IVA.text = "\(producto.propiedades.IVA) %"
        nombre.text = producto.nombre
        descripcion.text = producto.descripcion
        identificador.text = String(producto.id)
    }
    
    func initLabels(producto : Producto){
        
        
    }
    
   
}
