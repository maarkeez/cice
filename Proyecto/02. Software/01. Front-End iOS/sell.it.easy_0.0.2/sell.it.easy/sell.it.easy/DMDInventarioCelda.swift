//
//  DMDInventarioCelda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 2/4/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDEscanerCelda: UITableViewCell {

    
    //MARK: - Variables locales
    
    @IBOutlet weak var myCodigoBarras: UILabel!
    @IBOutlet weak var myCantidad: UILabel!
    //MARK: - IBOutlets
    
    //MARK: - LIFE VC
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
