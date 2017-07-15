//
//  celdaFecha.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class celdaFecha: UITableViewCell {

    @IBOutlet weak var myFecha: UILabel!
    @IBOutlet weak var myTexto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setIBOutlets(texto: String, fecha: Date){
        myTexto.text  = texto
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        myFecha.text = dateFormatter.string(from: fecha)
    }
    
}
