//
//  DMDCajaRegistradoraTableViewController.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDCajaRegistradoraTableViewController: UITableViewController {

    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    
    @IBOutlet weak var myCambiarTiendaBTN: UIButton!
    
    @IBAction func myCambiarTiendaACTION(_ sender: UIButton) {
        showSeleccionarTienda()
    }
    
    
    @IBOutlet weak var myTiendaLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mostrarMenu(myMenuBTN)
        
        myCambiarTiendaBTN.layer.cornerRadius = 5
        
        if Session.shared.tiendaSeleccionada == nil {
            showSeleccionarTienda()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let nombreTienda = Session.shared.tiendaSeleccionada?.nombre {
            myTiendaLBL.text = nombreTienda
        }else{
            myTiendaLBL.text = "Tienda sin seleccionar"
        }
    }
    
    func showSeleccionarTienda(){
        let nav = DMDTiendaSeleccionar()
        nav.delegado = self
        present(nav, animated: true, completion: nil)
    }
}


extension DMDCajaRegistradoraTableViewController : DMDTiendaSeleccionarDelegate {
    func didSelectTienda(_ tienda: Tienda){
        Session.shared.tiendaSeleccionada = tienda
        print("Tienda seleccionada: " + tienda.nombre)
    }
}
