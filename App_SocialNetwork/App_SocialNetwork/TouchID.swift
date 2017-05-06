//
//  TouchID.swift
//  App_SocialNetwork
//
//  Created by cice on 31/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit
//Para poder utilizar Touch ID
import LocalAuthentication

class TouchID: UIViewController {
    
    
    
    //MARK: - Variables locales
    var customTouchID = LAContext()
    var messageData = "Necesito saber si eres tú"
    var nombre = "David"
    var alertVC = UIAlertController(title: "", message: "", preferredStyle: .alert)
    var alertAction = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myLBLMomentoAuth: UILabel!
    @IBOutlet weak var myLBLMessageAuth: UILabel!
    @IBOutlet weak var myImagen: UIImageView!
    
    
    
    
    
    //MARK: - IBActions
    @IBAction func desbloqueoTouchID(_ sender: Any) {
        myLBLMomentoAuth.text = "Autenticando ..."
        var touchIDError : NSError?
        
        //Si puedo evaluar la política:
        //
        if customTouchID.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &touchIDError){
            
            //Evaluar la politica
            customTouchID.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                         localizedReason: messageData,
                                         reply: { (exitoso, error) in
                                            if(exitoso){
                                                self.myLBLMomentoAuth.text = "Touch ID Exitoso"
                                                self.myLBLMessageAuth.text = "Hombre! Cuanto tiempo!"
                                                self.alertVC.title = "Autenticación exitosa"
                                                self.alertVC.message = "Tú a mi me suenas \(self.nombre)"
                                                //pickerPhoto()
                                                
                                            }else{
                                                self.myLBLMomentoAuth.text = "Touch ID NO Exitoso"
                                                self.myLBLMessageAuth.text = "Fuera de aquí!!!"
                                                self.alertVC.title = "Autenticación NO exitosa"
                                                
                                                switch error!._code{
                                                case LAError.authenticationFailed.rawValue:
                                                    self.alertVC.message = "Fallo en la autenticación"
                                                case LAError.userCancel.rawValue:
                                                    self.alertVC.message = "Usuario cancela acción"
                                                case LAError.systemCancel.rawValue:
                                                    self.alertVC.message = "El sistema ha cancelado la acción"
                                                case LAError.userFallback.rawValue:
                                                    self.alertVC.message = "Acerca el dedo"
                                                default:
                                                    self.alertVC.message = "Otra cosa salió mal"
                                                }
                                            }
                                            self.present(self.alertVC, animated: true, completion: { 
                                                self.myLBLMessageAuth.text = self.messageData
                                            })
            })
            
            
        }else{
            
        }
        
        
        
    }
    
    
    //MARK: - LIFE VC
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Utils
    
}
