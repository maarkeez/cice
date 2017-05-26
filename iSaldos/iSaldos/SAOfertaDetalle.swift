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
            muestraPaginaWebAsociado(web)
        }
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
        if let oferta = oferta {
            myNombre.text = oferta.nombre
            myFecha.text = oferta.fechaFin
            myMasInformacion.text = oferta.masInformacion
            myDescripcionAsociado.text = oferta.asociado?.descripcion
            myDireccionAsociado.text = oferta.asociado?.direccion
            myTelefonoMovil.text = oferta.asociado?.telefonoMovil
            myEmail.text = oferta.asociado?.mail
            
            myWebURL.setTitle(oferta.asociado?.web, for: .normal)
            myTelefonoFijo.setTitle(oferta.asociado?.telefonoFijo, for: .normal)
        }
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.35, longitude: -3.80), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        let pointAnotation = MKPointAnnotation()
        pointAnotation.coordinate = CLLocationCoordinate2D(latitude: 40.35, longitude: -3.80)
        pointAnotation.title = oferta?.asociado?.direccion
        pointAnotation.subtitle = oferta?.asociado?.nombre
        myMapa.addAnnotation(pointAnotation)
        
        myMapa.setRegion(region, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
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
        
        webVC.urlWeb = url
        present(webVC, animated: true, completion: nil)
    }

}
