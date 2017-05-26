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
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myFecha: UILabel!
    @IBOutlet weak var myMasInformacion: UILabel!
    @IBOutlet weak var myDescripcionAsociado: UILabel!
    @IBOutlet weak var myDireccionAsociado: UILabel!
    @IBOutlet weak var myTelefonoMovil: UILabel!
    @IBOutlet weak var myEmail: UILabel!
    @IBOutlet weak var myMapAsociado: MKMapView!
    @IBOutlet weak var myTelefonoFijo: UIButton!
    @IBOutlet weak var myWebURL: UIButton!
    
    //MARK: - IBActions
    
    @IBAction func myLlamarFijoACTION(_ sender: UIButton) {
        //Recuperar el teléfono
        let telefono = sender.titleLabel?.text
        if let telefonoDes = telefono {
            llamar(telefonoDes)
        }
        
    }
    
    @IBAction func myCargarPaginaACTION(_ sender: UIButton) {
        if let web = sender.titleLabel?.text {
            accederURL(web)
        }
    }
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imagen = detalleImagen {
            myImagen.image = imagen
        }
        if let oferta = oferta {
            myNombre.text = oferta.nombre ?? ""
            myFecha.text = oferta.fechaFin ?? ""
            myMasInformacion.text = oferta.masInformacion ?? ""
            myDescripcionAsociado.text = oferta.asociado?.descripcion ?? ""
            myDireccionAsociado.text = oferta.asociado?.direccion ?? ""
            myTelefonoMovil.text = oferta.asociado!.telefonoMovil ?? ""
            myEmail.text = oferta.asociado!.mail ?? ""
            myWebURL.titleLabel?.text = oferta.asociado!.web ?? ""
            myTelefonoFijo.titleLabel?.text = oferta.asociado!.telefonoFijo! ?? ""
        }
    }

   

    //MARK: - Utils
    ///Permite llamar a un número de teléfono
    func llamar(_ telefono : String){
        if let phoneCallURL = URL(string: "tel://\(telefono)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    ///Permite llamar a un número de teléfono
    func accederURL(_ web : String){
        if let webURL = URL(string: "\(web)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(webURL)) {
                application.open(webURL, options: [:], completionHandler: nil)
            }
        }
    }

    ///Mostrar un viewcontroller con una web
    func muestraPaginaWebAsociado(_ url: String){
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "SAWebViewController") as! SAWebViewController
        
        webVC.urlWeb = stringWeb
        present(webVC, animated: true, completion: nil)
    }

}
