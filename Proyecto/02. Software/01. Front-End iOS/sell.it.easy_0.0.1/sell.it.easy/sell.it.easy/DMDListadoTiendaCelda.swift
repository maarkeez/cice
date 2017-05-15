//
//  DMDListadoTiendaCelda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDListadoTiendaCelda: UITableViewCell {

    
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myTelefono: UILabel!
    @IBOutlet weak var myImagenCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
