//
//  DMDVistaMiContactoCelda.swift
//  App_BarLogin
//
//  Created by cice on 3/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDVistaMiContactoCelda: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var myImagenContacto: UIImageView!
    @IBOutlet weak var myNombreContacto: UILabel!
    @IBOutlet weak var myApellidoContacto: UILabel!
    
    //MARK: - LIFE VCb
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func InicializarIBOutlets(imagen: UIImage, nombre: String, apellido: String){
        myImagenContacto.image = imagen
        myNombreContacto.text = nombre
        myApellidoContacto.text = apellido
    }
    
}
