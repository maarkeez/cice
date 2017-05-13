//
//  DMDCeldaTienda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 4/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDCeldaTienda: UITableViewCell {

    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombreTienda: UILabel!
    @IBOutlet weak var myTelefono: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initIBOutlets(tienda: Tienda ) {
        myImagen.image = tienda.imagen.imagenUI
        myNombreTienda.text = tienda.nombre
        myTelefono.text = tienda.telefono
    }

}
