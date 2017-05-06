//
//  DMDPerfilCustomCell.swift
//  App_XIB_vs_CELL
//
//  Created by cice on 20/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDPerfilCustomCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var fondoPerfil: UIImageView!
    @IBOutlet weak var imagenPerfil: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var biografia: UILabel!
    @IBOutlet weak var numeroPublicaciones: UILabel!
    @IBOutlet weak var numeroSeguidores: UILabel!
    @IBOutlet weak var numeroSeguidos: UILabel!
    @IBOutlet weak var botonEmail: UIButton!
    
    //MARK: - LIFE Celda
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
