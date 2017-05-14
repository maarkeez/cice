//
//  DMDDetalleProducto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDDetalleProducto: UITableViewController {

    
    //MARK: - Variables locales
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myCodigoEmpresa: UITextField!
    @IBOutlet weak var myCodigoBarras: UITextField!
    @IBOutlet weak var myCoste: UITextField!
    @IBOutlet weak var myDescuento: UITextField!
    @IBOutlet weak var myPVP: UITextField!
    @IBOutlet weak var myImagen: UIImageView!
    
    @IBOutlet weak var myNombre: UITextField!
    
    @IBOutlet weak var myTalla: UITextField!
    @IBOutlet weak var myDescripcion: UITextView!
    //MARK: - IBActions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    

}
