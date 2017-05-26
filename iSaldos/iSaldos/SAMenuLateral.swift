//
//  SAMenuLateral.swift
//  iSaldos
//
//  Created by David Márquez Delgado on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import MessageUI


class SAMenuLateral: UITableViewController {

    //MARK: - Variables locales
    
    //MARK: - IBOutlets
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myApellido: UILabel!
    @IBOutlet weak var myEmail: UILabel!
    @IBOutlet weak var myImagen: UIImageView!
    
    
    //MARK: - IBActions
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar información del usuario
        dameInformacionParse()
        
        
        //Editar forma de la imagen
        myImagen.layer.cornerRadius = myImagen.frame.width / 2
        myImagen.layer.borderColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myImagen.layer.borderWidth = 1
        myImagen.clipsToBounds = true
        
    }
    
    //MARK: - Utils
    
    ///Recuperar la información sobre el usuario
    ///Recupera la imagen si se puede recuperar el usuario
    ///De la imagen, recupera los bytes de la misma usando parse en todo el proceso
    func dameInformacionParse(){
        
        // ------------------------------------------
        // -- 1. Consulta: Datos del usuario
        // ------------------------------------------
        
        //Instacia de la consulta
        let queryData = PFUser.query()
        
        //Recupero el usuario cuyo nombre de usuario es el que ha inciado la sesión
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        
        //Hacer la consulta del usuario en segundo plano.
        queryData?.findObjectsInBackground(block: { (usuarios, errorUno) in
            if let error = errorUno {
                //Si se ha producido un error
                print("Error 1 : \(error.localizedDescription)")
            }else{
                //Si se han recuperado datos para el nombre de usuario
                if let primerUsuario = usuarios?[0] {
                    //Mostrar los valores para el usuario
                    self.myNombre.text = primerUsuario["nombre"] as? String
                    self.myApellido.text = primerUsuario["apellido"] as? String
                    self.myEmail.text = primerUsuario["email"] as? String
                    
                    // ------------------------------------------
                    // -- 2. Consulta: Obtener foto del usuario
                    // ------------------------------------------
                    let queryFoto = PFQuery(className: "ImageProfile")
                    queryFoto.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    queryFoto.findObjectsInBackground(block: { (fotos, errorDos) in
                        if let error = errorDos{
                            //Si se ha producido un error en la consulta
                            print("Error 2 : \(error.localizedDescription)")
                        }else{
                            //Si he podido recuperar las fotos
                            if let foto = fotos?[0]{
                                //Recuperar la imagen
                                let imageDataFile = foto["imageProfile"] as! PFFile
                                
                                // ------------------------------------------
                                // -- 3. Consulta: Obtener bytes de la foto
                                // ------------------------------------------
                                imageDataFile.getDataInBackground(block: { (imageData, errorTres) in
                                    if let error = errorTres {
                                        //Si se ha producido un error
                                        print("Error 3 : \(error.localizedDescription)")
                                    }else{
                                        //si hemos podido recuperar los datos para la foto
                                        if let bytesImagen = imageData{
                                            //Construir instancia de la imagen
                                            let imageDataFinal = UIImage(data: bytesImagen)
                                            self.myImagen.image = imageDataFinal
                                            
                                        }
                                    }
                                })
                            }
                        }
                    })
                    
                    
                }
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            //
            switch indexPath.row {
            case 2:
                sendMessage()
            case 3:
                showRateAlertInmediatly(self)
            case 4:
                logout()
            default:
                break
            }
        }
    }
    
    func sendMessage(){
        let mailComposeVC = configureMailCompose()
        mailComposeVC.mailComposeDelegate = self
        
        if MFMailComposeViewController.canSendMail() {
            present(mailComposeVC, animated: true, completion: nil)
        }else{
            present(muestraAlertVC("Atención", messageData: "El email no se envió"), animated: true, completion: nil)
            
        }
        
    }
    
    func logout(){
        PFUser.logOut()
    }

}

//MARK: - Extensión para la plantilla de email
extension SAMenuLateral : MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}





















