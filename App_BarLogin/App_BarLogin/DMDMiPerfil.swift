//
//  DMDMiPerfil.swift
//  App_BarLogin
//
//  Created by cice on 3/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDMiPerfil: UIViewController {
    
    // http://cice.es
    
    //MARK: - Variables locales
    let urlData = "https://www.youtube.com/embed/XHgcrtD69QI"
    var contacto : Contacto!
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myApellido: UILabel!
    
    @IBOutlet weak var mySeguidores: UILabel!
    @IBOutlet weak var myUsuarioTwitter: UILabel!
    
    @IBOutlet weak var myFechaCreacion: UILabel!
    @IBOutlet weak var myAbstracto: UILabel!
    @IBOutlet weak var myDescripcion: UILabel!
    @IBOutlet weak var myTelefonoMovil: UILabel!
    @IBOutlet weak var myTelefonoTrabajo: UILabel!
    @IBOutlet weak var myEmail: UILabel!
    @IBOutlet weak var myLinkedin: UILabel!
    
    
    @IBAction func cerrar(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Comprobamos por si estoy visitando una celda
        if (contacto != nil ){
            //Si hay contacto, he seleccionado la celda XXX.
            initIBOutlets()
        }
        // Do any additional setup after loading the view.
        
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        myImagen.isUserInteractionEnabled = true
        myImagen.addGestureRecognizer(swipeDown)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Si se está pasando el segue por el que enviar y apunto a mi vista que muestra la web
        if (segue.identifier == "muestraWeb"){
            //Creo un destino para el webview de mi controller de web
            let WebVC = segue.destination as! DMDWeb
            //Asigno la URL para acceder a ella en mi webcontroller
            WebVC.URLString = urlData
        }
    }
    

    func initIBOutlets(){
        myImagen.image = UIImage(named: contacto["imageProfile"]! as! String)
        myNombre.text = contacto["firstName"] as! String
        myApellido.text = contacto["lastName"]  as! String
        mySeguidores.text = contacto["numeroSeguidores"] as! String
        myUsuarioTwitter.text = contacto["usernameTwitter"] as! String
        myFechaCreacion.text = contacto["createdPost"] as! String
        myAbstracto.text = contacto["abstractoVC"] as! String
        myDescripcion.text = contacto["description"] as! String
        myTelefonoMovil.text = contacto["telefonoMovil"] as! String
        myTelefonoTrabajo.text = contacto["telefonoTrabajo"] as! String
        myEmail.text = contacto["email"] as! String
        myLinkedin.text = contacto["cuentaLinkedin"] as! String
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                UIView.animate(withDuration: 0.5, delay: 0.0 , usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: { 
                    self.myImagen.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                    }, completion: nil)
                
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    
}
