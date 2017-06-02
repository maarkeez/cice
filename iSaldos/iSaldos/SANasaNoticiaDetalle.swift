//
//  SANasaNoticiaDetalle.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SANasaNoticiaDetalle: UITableViewController {
    //MARK: - Variables locales
    var noticia : SANasaModel?
    var detalleImagen : UIImage?
    
    //MARK: - IBOutltes
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myFecha: UILabel!
    @IBOutlet weak var myMasInformacion: UILabel!
    @IBOutlet weak var myDescripcionAsociado: UILabel!
    @IBOutlet weak var myDireccionAsociado: UILabel!
    @IBOutlet weak var myWebURL: UIButton!
    
    //MARK: - IBActions
    
 
    
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
        if let noticia = noticia {
            myNombre.text = noticia.title
            myFecha.text = formatDate(noticia.fecha)
            myMasInformacion.text = "Noticia de la NASA"
            myDescripcionAsociado.text = noticia.explanation
            
            
            
            myWebURL.setTitle(noticia.hdurl, for: .normal)
        }
        
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
