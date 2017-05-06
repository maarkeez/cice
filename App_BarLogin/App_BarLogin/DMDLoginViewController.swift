//
//  DMDLoginViewController.swift
//  App_BarLogin
//
//  Created by cice on 27/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDLoginViewController: UIViewController {

    //MARK:- Variables Locales
    var viewAnimator : UIViewPropertyAnimator!
    var desbloqueoGesto = Timer()
    
    var animacionChula : UIViewPropertyAnimator!
    
    //MARK:- IBOutlets
    @IBOutlet weak var myLogo: UIImageView!
    @IBOutlet weak var myLabel: UIImageView!
    @IBOutlet weak var myUsuarioLBL: UILabel!
    @IBOutlet weak var myUsuarioText: UITextField!
    @IBOutlet weak var myPasswordLBL: UILabel!
    @IBOutlet weak var myPasswordText: UITextField!
    @IBOutlet weak var myBotonEntrarBTN: UIButton!
    
    //MARK:- IBActions
    @IBAction func cambiarDeViewController(_ sender: AnyObject) {
        //Me limita la acción al tamaño del botón
        let customBound = myBotonEntrarBTN.bounds
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: { 
            self.myBotonEntrarBTN.bounds = CGRect(x: customBound.origin.x - 20 /* lo encojo por los lados izqui y derecha*/, y: customBound.origin.y /* mantenemos la altura*/, width: customBound.width + 20 /* lo voy a  ampliar hasta 20 puntos más */, height: customBound.height)
            }) { Void in
                //Creamos el controlador de la tabla
                let tabViewController = self.storyboard?.instantiateViewController(withIdentifier : "RootTabBarViewController") as! DMDRootTabBarViewController
                tabViewController.modalTransitionStyle = .crossDissolve
                self.present(tabViewController, animated: true, completion: nil)
                
                
                
                preferencias.set(true, forKey: "Lanzamiento")
        }
    }
    
    //MARK:- LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        //Redondeamos las esquinas del botón
        myBotonEntrarBTN.layer.cornerRadius = 3
        
        
        
        objetosSinOpacidad()
        objetosDesplazados()
        
        //Animación para el logotipo de batman
        //Se colocarán todos los labels subiendo uno detrás de otro
        //Aparecerá siendo grande y se hará pequeño
        viewAnimator = UIViewPropertyAnimator(duration: 0.0, curve: .easeOut, animations: {
            self.myLogo.transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
            self.desbloqueoGesto = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.volverATamanio), userInfo: nil, repeats: false)
        })

        viewAnimator.startAnimation()
    
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Iniciamos la animación
        iniciaAnimacion()
    }

    
    //MARK:- Utils
    func volverATamanio(){
        let animacionVolverTamanio = UIViewPropertyAnimator(duration: 1.3, curve: .easeIn) {
            self.myLogo.layer.opacity = 1
            self.myLogo.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        animacionVolverTamanio.startAnimation()
    }
    
    //Hacemos los objetos transparentes
    func objetosSinOpacidad(){
        myLogo.layer.opacity = 0
        myLabel.layer.opacity = 0
        myUsuarioLBL.layer.opacity = 0
        myUsuarioText.layer.opacity = 0
        myPasswordLBL.layer.opacity = 0
        myPasswordText.layer.opacity = 0
        myBotonEntrarBTN.layer.opacity = 0
        
    }
    
    //Movemos los objetos de la pantalla
    func objetosDesplazados(){
        myLogo.transform = CGAffineTransform(translationX: 0, y: 620)
        myLabel.transform = CGAffineTransform(translationX: 0, y: 620)
        myUsuarioLBL.transform = CGAffineTransform(translationX: 0, y: 620)
        myUsuarioText.transform = CGAffineTransform(translationX: 0, y: 620)
        myPasswordLBL.transform = CGAffineTransform(translationX: 0, y: 620)
        myPasswordText.transform = CGAffineTransform(translationX: 0, y: 620)
        myBotonEntrarBTN.transform = CGAffineTransform(translationX: 0, y: 620)
    }
    
    func iniciaAnimacion(){
        //getAnimacion(duracion: 0.6, objeto: self.myLogo)
        getAnimacion(duracion: 0.7, objeto: self.myLabel)
        getAnimacion(duracion: 0.8, objeto: self.myUsuarioLBL)
        getAnimacion(duracion: 0.9, objeto: self.myUsuarioText)
        getAnimacion(duracion: 0.9, objeto: self.myPasswordLBL)
        getAnimacion(duracion: 1.0, objeto: self.myPasswordText)
        getAnimacion(duracion: 1.1, objeto: self.myBotonEntrarBTN)
        
    }
    
    
    func getAnimacion(duracion : Double, objeto : UIView){
        animacionChula = UIViewPropertyAnimator(duration: duracion, curve: .easeInOut, animations: {
            //Mostramos el Logo de Batman
            objeto.layer.opacity = 1
            //Respetamos el tamaño, constrains, etc. TODO lo que está en el StoryBoard
            objeto.transform = CGAffineTransform.identity
        })
        animacionChula.startAnimation()
        

    }
}
