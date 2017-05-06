//
//  DMDContactosCustomCell.swift
//  AppTestTableViewMasterDetail
//
//  Created by cice on 13/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDContactosCustomCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var Nombre: UILabel!
    @IBOutlet weak var Apellido: UILabel!
    @IBOutlet weak var Telefono: UILabel!
    //Aspect fill - Clip to Bounds , para ajustar al tamaño
    @IBOutlet weak var ImagenContacto: UIImageView!
    @IBOutlet weak var imgTelefono: UIImageView!
    
    
    // MARK: - LIFE VC
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
