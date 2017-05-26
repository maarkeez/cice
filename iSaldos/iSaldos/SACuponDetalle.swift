//
//  SACuponDetalle.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SACuponDetalle: UITableViewController {

    //MARK: - Variables locales
    var cupon : SAPromocionesModel?
    var detalleImagen : UIImage?
    
    //MARK: - Variables CodigoBarras
    var qrData : String?
    var imageGroupTag = 3
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myFecha: UILabel!
    @IBOutlet weak var myMasInformacion: UILabel!
    @IBOutlet weak var myDescripcionAsociado: UILabel!
    @IBOutlet weak var myDireccionAsociado: UILabel!
    @IBOutlet weak var myTelefonoMovil: UILabel!
    @IBOutlet weak var myEmail: UILabel!
    @IBOutlet weak var myTelefonoFijo: UILabel!
    @IBOutlet weak var myWebURL: UILabel!
    
    @IBOutlet weak var myIdActividadAsociado: UILabel!
    
    
    //MARK: - IBActions
    
    @IBAction func muestraBarCodeACTION(_ sender: UIButton) {
        
        
    }
    
    @IBAction func muestraActionSheetPersonalizado(_ sender: UIBarButtonItem) {
        
        
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Indicar tamaños dinámicos para toda la tabla.
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if let imagen = detalleImagen {
            myImagen.image = imagen
        }
        if let cupon = cupon {
            myNombre.text = cupon.nombre
            myFecha.text = cupon.fechaFin
            myMasInformacion.text = cupon.masInformacion
            myDescripcionAsociado.text = cupon.asociado?.descripcion
            myDireccionAsociado.text = cupon.asociado?.direccion
            myTelefonoMovil.text = cupon.asociado?.telefonoMovil
            myEmail.text = cupon.asociado?.mail
            
            myWebURL.text = cupon.asociado?.web
            myTelefonoFijo.text = cupon.asociado?.telefonoFijo
            myIdActividadAsociado.text = cupon.id
        }
        

        
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    

   
}
