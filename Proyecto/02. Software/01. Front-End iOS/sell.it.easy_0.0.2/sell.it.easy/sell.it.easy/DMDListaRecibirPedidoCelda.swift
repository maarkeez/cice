//
//  DMDListaRecibirPedidoCelda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDListaRecibirPedidoCeldaDelegate {
    func setCantidad(_ id: Int, cantidad: Int)
}

class DMDListaRecibirPedidoCelda: UITableViewCell {
    
    //MARK: - Variables locales
    var idProducto : Int?
    var delegate : DMDListaRecibirPedidoCeldaDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myCodigoDeBarras: UILabel!
    @IBOutlet weak var myCantidad: UILabel!
    @IBOutlet weak var myStepper: UIStepper!
    
    //MARK: - IBActions
    @IBAction func modificarCantidadACTION
        (_ sender: UIStepper) {
        
        myCantidad.text = "\(Int(sender.value))"
        delegate?.setCantidad(idProducto!, cantidad: Int(sender.value))
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
