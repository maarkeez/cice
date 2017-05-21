//
//  DMDLauncher.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 21/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDLauncher: UIViewController {

    //MARK: - Variables locales
    var viewAnimator : UIViewPropertyAnimator!
    var timerDesbloqueo = Timer()

    //MARK: - IBOutlets
    @IBOutlet weak var myIcono: UIImageView!
    @IBOutlet weak var myTitulo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Crear animación para la vista
        viewAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut, animations: {
            //Hacer pequeña la imagen
            self.myIcono.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            //Configurar timer para desbloquear la imagen a 1.5 segundos
            self.timerDesbloqueo = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.hacerGrande), userInfo: nil, repeats: false)
        })
        
        viewAnimator.startAnimation()
        
    }

    ///Funcion que permite aumentar el logo y comenzar la App
    func hacerGrande(){
        //Cear animación para el logo, depues de hacerlo pequeño
        let logoAnimacion = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            //Ampliar el logo
            self.myIcono.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        //Comenzar animación
        logoAnimacion.startAnimation()
        
        //Llamada al terminar la animación
        logoAnimacion.addCompletion { (_) in
            self.hacerPequeno()
        }
        
    }
    
    ///Funcion que permite aumentar el logo y comenzar la App
    func hacerPequeno(){
        //Cear animación para el logo, depues de hacerlo pequeño
        let logoAnimacion = UIViewPropertyAnimator(duration: 1.0, curve: .easeInOut) {
            //Ampliar el logo
            self.myIcono.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.myTitulo.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.view.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*3))

        }
        
        //Comenzar animación
        logoAnimacion.startAnimation()
        
        //Llamada al terminar la animación
        logoAnimacion.addCompletion { (_) in
            self.beginApp()
        }
        
    }
    
    
    
    func beginApp() {
        //Si no existe el usuario, muestro el login
        let inicioVC = self.storyboard?.instantiateViewController(withIdentifier: "DMDLogin") as! DMDLogin
        inicioVC.modalTransitionStyle = .crossDissolve
        present(inicioVC, animated: true, completion: nil)
    }
    
   

}
