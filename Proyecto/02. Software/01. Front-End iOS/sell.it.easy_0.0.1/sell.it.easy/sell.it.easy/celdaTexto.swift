//
//  celdaTexto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class celdaTexto: UITableViewCell {

    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myValor: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setIBOutlets(nombre: String, valor: String){
        myNombre.text = nombre
        myValor.text = valor
    }
    
}

