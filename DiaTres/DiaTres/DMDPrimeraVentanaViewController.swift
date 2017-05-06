//
//  DMDPrimeraVentanaViewController.swift
//  DiaTres
//
//  Created by CICE on 2/12/16.
//  Copyright © 2016 DMD. All rights reserved.
//

import UIKit

class DMDPrimeraVentanaViewController: UIViewController {
    
    
    
    //MARK: - Variables locales globales
    var miNombreLogin : UITextField?
    var miApellido : UITextField?
    var miTelefono : UITextField?
    var miCorreo : UITextField?
    var miCP : UITextField?
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myLoginFacebook: UILabel!
    
    
    
    
    
    //MARK: - IBActions
    //Controlador de alertas en función del botón pulsado.
    @IBAction func MuestraAlertVC(_ sender: AnyObject) {
        //Realizar acciones diferentes en función de valor de la propiedad "tag" del botón
        switch sender.tag {
        case 0:
            //Definimos el controlador para el botón
            let alertVC = UIAlertController(
                title: "Alert Controller Standard",
                message: "Este es un alert view controller que me muestra cosas por defecto",
                preferredStyle: .alert)
            
            //Definimos las acciones que tendrá el botón
            let cancelAction = UIAlertAction(
                title: "Cancelar",
                style: .cancel,
                handler: { (Void) in
                print("Ha sido pulsado el botón cancelar.")
            })
            
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (Void) in
                print("Ha sido pulsado el botón OK")
            })
            
            //Añadimos las acciones al controlador
            alertVC.addAction(okAction)
            alertVC.addAction(cancelAction)

            
            //Mostramos la alerta configurada
            present(alertVC, animated: true, completion: nil)

        case 1:
            //Definimos el controlador para el botón
            let alertVCConTextField = UIAlertController(
                title: "Alert con TextField",
                message: "Este es un alert view que me modifica una etiqueta.",
                preferredStyle: .alert)
            
            //Definimos las acciones que tendrá el botón
            let cancelAction = UIAlertAction(
                title: "Cancelar",
                style: .cancel,
                handler: { (Void) in
                    print("Ha sido pulsado el botón cancelar.")
            })
            
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (Void) in
                    self.myLoginFacebook.text = self.miNombreLogin?.text
            })
            
            //Añadimos las acciones al controlador
            alertVCConTextField.addAction(okAction)
            alertVCConTextField.addAction(cancelAction)
            
            //Añadimos el campo de texto
            alertVCConTextField.addTextField(configurationHandler: { (myTextField) in
                self.miNombreLogin = myTextField
                self.miNombreLogin?.placeholder = "Inserte aquí su login"
            })
            
            
            
            //Mostramos la alerta configurada
            present(alertVCConTextField, animated: true, completion: nil)
        case 2:
            //Definimos el controlador para el botón
            let alertVCConTextFieldLoginPass = UIAlertController(
                title: "Regístrate!",
                message: "Este es un alert con formulario",
                preferredStyle: .alert)
            
            //Definimos las acciones que tendrá el botón
            let cancelAction = UIAlertAction(
                title: "Cancelar",
                style: .cancel,
                handler: { (Void) in
                    print("Ha sido pulsado el botón cancelar.")
            })
            
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (Void) in
                    //***
                    //* Modificamos la etiqueta, añadiendo todos los campos a una etiqueta
                    //***
                    var myLabel = ""
                    //Desempaquetado inseguro (se puede aceptar porque el text por defecto nunca es nil. Siempre es "" o "Valor"
                    myLabel += "Name:\(self.miNombreLogin!.text!)"
                    myLabel += "\nLastName:\(self.miApellido!.text!)"
                    myLabel += "\nTelf:\(self.miTelefono!.text!)"
                    
                    //Desempaquetado seguro
                    if let varCorreo = self.miCorreo?.text{
                        myLabel += "\nE-Mail:\(varCorreo)"
                    }
                    
                    myLabel += "\nCP:\(self.miCP!.text!)"
                    self.myLoginFacebook?.text = myLabel

            })
            
            //Añadimos las acciones al controlador
            alertVCConTextFieldLoginPass.addAction(okAction)
            alertVCConTextFieldLoginPass.addAction(cancelAction)
            
            //Añadimos el campo de texto
            alertVCConTextFieldLoginPass.addTextField(configurationHandler: { (myTextField) in
                self.miNombreLogin = myTextField
                self.miNombreLogin?.placeholder = "Inserte aquí su login"
            })
            alertVCConTextFieldLoginPass.addTextField(configurationHandler: { (myTextField) in
                self.miApellido = myTextField
                self.miApellido?.placeholder = "Inserte aquí su apellido"
            })
            alertVCConTextFieldLoginPass.addTextField(configurationHandler: { (myTextField) in
                self.miCorreo = myTextField
                self.miCorreo?.placeholder = "Inserte aquí su correo"
            })
            alertVCConTextFieldLoginPass.addTextField(configurationHandler: { (myTextField) in
                self.miTelefono = myTextField
                self.miTelefono?.isSecureTextEntry  = true
                self.miTelefono?.placeholder = "Inserte aquí su teléfono"
            })
            alertVCConTextFieldLoginPass.addTextField(configurationHandler: { (myTextField) in
                self.miCP = myTextField
                self.miCP?.placeholder = "Inserte aquí su código postal"
            })
            
            //Mostramos la alerta configurada
            present(alertVCConTextFieldLoginPass, animated: true, completion: nil)

        case 3:
            //Definimos el controlador para el botón
            let alertVC = UIAlertController(
                title: "Alert Multibotones",
                message: "Este es un alert view controller que me muestra varias acciones",
                preferredStyle: .alert)
            
            //Definimos las acciones que tendrá el botón
            let cancelAction = UIAlertAction(
                title: "Cancelar",
                style: .cancel,
                handler: { (Void) in
                    print("Ha sido pulsado el botón cancelar.")
            })
            
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (Void) in
                    print("Ha sido pulsado el botón OK")
            })
            
            let btn1Action = UIAlertAction(
                title: "Botón 1",
                style: .default,
                handler: { (Void) in
                    print("Ha sido pulsado el botón 2")
            })
            
            
            let btn2Action = UIAlertAction(
                title: "Botón 2",
                style: .default,
                handler: { (Void) in
                    print("Ha sido pulsado el botón 2")
            })
            
            let destructiveAction = UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { (Void) in
                    print("Ha sido pulsado el botón Destructive")
            })

            
            //Añadimos las acciones al controlador
            alertVC.addAction(cancelAction)
            alertVC.addAction(destructiveAction)
            alertVC.addAction(okAction)
            alertVC.addAction(btn1Action)
            alertVC.addAction(btn2Action)

            
            //Mostramos la alerta configurada
            present(alertVC, animated: true, completion: nil)
        case 4:
            //Definimos el controlador para el botón
            let alertVC = UIAlertController(
                title: "Action Sheet",
                message: "Elige una opción",
                preferredStyle: .actionSheet)
            
            //Definimos las acciones que tendrá el botón
            let selectFotografia = UIAlertAction(
                title: "Selecciona una fotografía de tu biblioteca",
                style: .default,
                handler: { (Void) in
                    self.seleccionaFotografia()
            })
            
            let tomarFotografia = UIAlertAction(
                title: "Toma una fotografía",
                style: .default,
                handler: { (Void) in
                    //Trabajamos con delegados.
                    //Se va conectar con la cámara del dispositivo.
                    self.tomarFotografia()
            
            })
            
            
           
            
            let destructiveAction = UIAlertAction(
                title: "Cancelar",
                style: .cancel,
                handler: { (Void) in
                    print("Ha sido pulsado el botón Destructive")
            })
            
            
            
            //Añadimos las acciones al controlador
            alertVC.addAction(selectFotografia)
            alertVC.addAction(tomarFotografia)
            alertVC.addAction(destructiveAction)

            
            
            //Mostramos la alerta configurada
            present(alertVC, animated: true, completion: nil)

        default:
            print("Acción por defecto")
            
        }
    
    
    
    
    }
    
    
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}//MARK: - FIN DE LA CLASE

//MARK: - DELEGADOS
//Establecemos los delegados
extension DMDPrimeraVentanaViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: - Funciones
    func tomarFotografia(){
        //Indicamos la variable que nos va a permitir acceder a la cámara.
        let imagePicker = UIImagePickerController()
        //Asocio como delegado a la clase actual
        imagePicker.delegate = self
        //Indicamos los permisos que queremos para la cámara
        imagePicker.sourceType = .camera
        //Permitimos editar la imagen desde nuestra App
        imagePicker.allowsEditing = true
        
        imagePicker.showsCameraControls = true
        
        present(imagePicker,animated: true,completion: nil)
        
    }
    
    func seleccionaFotografia(){
        //Indicamos la variable que nos va a permitir acceder a la cámara.
        let imagePicker = UIImagePickerController()
        //Asocio como delegado a la clase actual
        imagePicker.delegate = self
        //Indicamos los permisos que queremos para la galería de fotos
        imagePicker.sourceType = .photoLibrary
        //Permitimos editar la imagen desde nuestra App
        imagePicker.allowsEditing = true
        
        present(imagePicker,animated: true,completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
}

