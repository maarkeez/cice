//
//  SASplashViewController.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class SASplashViewController: UIViewController {

    
    //MARK: - Variables locales
    var viewAnimator : UIViewPropertyAnimator!
    var timerDesbloqueo = Timer()
    
    //MARK: - IBOulets
    @IBOutlet weak var mySplash: UIImageView!
    
    //MARK: - IBActions
    
    
    //MARK: - LIFE VCß
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Crear animación para la vista
        viewAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: { 
            //Hacer pequeña la imagen
            self.mySplash.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            //Configurar timer para desbloquear la imagen a 1.5 segundos
            self.timerDesbloqueo = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.manejadorAutomatico), userInfo: nil, repeats: false)
        })
    
    
    
    }
    
    
    //MARK: - Utils
    
    ///Funcion que permite aumentar el logo y comenzar la App
    func manejadorAutomatico(){
        //Cear animación para el logo, depues de hacerlo pequeño
        let logoAnimacion = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            //Ampliar el logo
            self.mySplash.transform = CGAffineTransform(scaleX: 25, y: 25)
        }
        
        //Comenzar animación
        logoAnimacion.startAnimation()
        
        //Llamada al terminar la animación
        logoAnimacion.addCompletion { (_) in
            self.beginApp()
        }
        
    }
    
    
    /// Permite inicializar directamente en la galería o en el registro
    func beginApp(){
        
        //Comprobar si es el primer acceso a la Aplicación
        if(customPrefs.string(forKey: CONSTANTES.CUSTOM_USER_DEFAULTS.VISTA_GALERIA_INICIAL)) != nil {
            
            //Comprobar si el usuario existe
            if PFUser.current() == nil {
                
                //Si no existe el usuario, muestro el login
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "SALoginViewController") as! SALoginViewController
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: true, completion: nil)
                
                
            }else{
                
                //Si existe el usuario, recuperamos el menú lateral de las clases de Obj-C
                let revealVC = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                revealVC.modalTransitionStyle = .crossDissolve
                present(revealVC, animated: true, completion: nil)
            }
        }else{
            //Dar valor al check de usersdefaults
            customPrefs.setValue("OK", forKey: CONSTANTES.CUSTOM_USER_DEFAULTS.VISTA_GALERIA_INICIAL)
            
            //Recuperar view controller de la galería
            let galeriaVC = self.storyboard?.instantiateViewController(withIdentifier: "SAGaleriaImagenesViewController") as! SAGaleriaImagenesViewController
            galeriaVC.modalTransitionStyle = .crossDissolve
            present(galeriaVC, animated: true, completion: nil)
        }
    }
    

}
