//
//  DMDSplashViewController.swift
//  App_BarLogin
//
//  Created by cice on 27/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDSplashViewController: UIViewController {
    
    
    //MARK:- Variables locales
    var viewAnimator : UIViewPropertyAnimator!
    var desbloqueoGesto = Timer()
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var myLogo: UIImageView!
    @IBOutlet weak var myMarca: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Disminuimos la imagen del logo, para crear una animación durante 1 seg
        viewAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: nil)
        
        //Añadimos una animación al logo, al segundo y medio se hará algo más pequeño
        viewAnimator.addAnimations {
            //Hacemos transparente a la etiqueta
            self.myMarca.layer.opacity = 0
            //Realizamos la transformación como un factor de escala
            self.myLogo.transform = CGAffineTransform(scaleX: 0.7, y: 0.7 )
            self.desbloqueoGesto = Timer.scheduledTimer(timeInterval: 1.5,
                                                        target: self,
                                                        selector: #selector(self.muestraAutomatico),
                                                        userInfo: nil,
                                                        repeats: false)
        }
        
        viewAnimator.startAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func muestraAutomatico() {
        //Aquí creamos la otra animación, donde se hará grande el logo
        let logoAnimation = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.myLogo.transform = CGAffineTransform(scaleX: 25, y: 25)
        }
        //Comenzamos la animación
        logoAnimation.startAnimation()
        
        //Creamos un callback
        logoAnimation.addCompletion{ Void in
            self.comienzoApp()
        }
    }
    func comienzoApp(){
        if(!preferencias.bool(forKey: "Lanzamiento")){
            let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! DMDLoginViewController
            //Forma de presentación de la vista controlador
            //Por defecto se mostraría apareciendo de abajo hacia arriba.
            //Con corssdissolve
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: true, completion: nil)
        }else{
            
            let tabViewController = self.storyboard?.instantiateViewController(withIdentifier : "RootTabBarViewController") as! DMDRootTabBarViewController
            tabViewController.modalTransitionStyle = .crossDissolve
            self.present(tabViewController, animated: true, completion: nil)
        }
        
    }
    
}
