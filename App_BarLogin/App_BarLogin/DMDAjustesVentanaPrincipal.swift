//
//  DMDAjustesVentanaPrincipal.swift
//  App_BarLogin
//
//  Created by David Márquez Delgado on 25/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDAjustesVentanaPrincipal: UITableViewController {
    //MARK : - Variables locales
    let URL_ICO_SPARTAN = "https://appsto.re/es/2cYc8.i"
    //MARK : - IBOutlets
    @IBOutlet weak var myPuntuaApp: UIView!
    @IBOutlet weak var myRecomiendaApp: UIView!
    @IBOutlet weak var myDesconectar: UIView!
    
    //MARK : - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        //Gesto que permite abrir APPLE STORE
        let gesture = UITapGestureRecognizer(target: self, action: #selector(abrirAppleStore))
        self.myPuntuaApp.addGestureRecognizer(gesture)
        
        //Gesto que permite recomendar APP
        let recomendarGesto = UITapGestureRecognizer(target: self, action: #selector(compartirTexo))
        self.myRecomiendaApp.addGestureRecognizer(recomendarGesto)
        
        //Gesto que permite recomendar APP
        let apagarGesto = UITapGestureRecognizer(target: self, action: #selector(desconectarApp))
        self.myDesconectar.addGestureRecognizer(apagarGesto)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK : - Funciones de la tabla
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            showMiInformacion()
        case 1:
            showContacto()
        case 2:
            showConfiguracion()
        default:
            print("Celda sin acción.")
        }
    }
    
    //MARK : - Utils
    func showMiInformacion(){
        muestraMiPerfilVCGlobal(navigationGlobal: self)
        
    }
    
    func showContacto(){
        let telefono = "919999999"
        let alert = UIAlertController(title: "Contacto", message: telefono, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Calcelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Llamar", style: .default) { (Void) in
            self.llamar(telefono)
        })
        present(alert, animated: true, completion: nil)
    }
    
    func showConfiguracion(){
        guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    func llamar(_ telefono : String){
        if let phoneCallURL = URL(string: "tel://\(telefono)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func abrirAppleStore(){
        if let URL_APPLE_STORE = URL(string: URL_ICO_SPARTAN) {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(URL_APPLE_STORE)) {
                application.open(URL_APPLE_STORE, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    
    func compartirTexo( ){
        let text = URL_ICO_SPARTAN
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func desconectarApp(){
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! DMDLoginViewController
        //Forma de presentación de la vista controlador
        //Por defecto se mostraría apareciendo de abajo hacia arriba.
        //Con corssdissolve
        loginVC.modalTransitionStyle = .crossDissolve
        present(loginVC, animated: true, completion: nil)
        
    }
    
    
}

