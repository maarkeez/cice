//
//  SAOfertaDetalle.swift
//  iSaldos
//
//  Created by David Márquez Delgado on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import MapKit

class SAOfertaDetalle: UITableViewController {

    /*
     
     
     var id : String?
     var tipoPromocion : String?
     var nombre : String?
     var importe : String?
     var imagen : String?
     var fechaFin : String?
     var masInformacion: String?
     var asociado : SAAsociadoModel?
     
     
     
     var id : String?
     var nombre : String?
     var descripcion : String?
     var condicionesEspeciales : String?
     var direccion : String?
     var idActividad : String?
     var idLocalidad : String?
     var imagen : String?
     var telefonoFijo : String?
     var telefonoMovil : String?
     var mail : String?
     var web : String?
     
     */
    
    //MARK: - Variables locales
    var oferta : SAPromocionesModel?
    var detalleImagen : UIImage?
    
    //MARK: - IBOutltes
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myMapa: MKMapView!
    
    //MARK: - IBActions
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imagen = detalleImagen {
            myImagen.image = imagen
        }
    }

   

    //MARK: - Utils
   

}
