//
//  SARegistroTableViewController.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse


class SARegistroTableViewController: UITableViewController {

    //MARK: - Varibles locales
    var fotoSeleccionada = false
    
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myUsername: UITextField!
    @IBOutlet weak var myPassword: UITextField!
    @IBOutlet weak var myNombre: UITextField!
    @IBOutlet weak var myApellido: UITextField!
    @IBOutlet weak var myEmail: UITextField!
    @IBOutlet weak var myMovil: UITextField!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    
    
    //MARK: - IBActions
    ///Permite ocultar la página de registro
    @IBAction func hideACTION(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    ///Registrarse en la aplicación con los datos introducidos
    @IBAction func registroEnParseACTION(_ sender: Any) {
        
        
        if esVacia(myUsername.text) ||  esVacia(myPassword.text) || esVacia(myNombre.text) || esVacia(myApellido.text) ||  esVacia(myEmail.text) || !isValidEmail( myEmail.text!) || myImagen.image == nil {
            
            present(muestraAlertVC("Atención", messageData: "Estimado usuario por favor relle los campos y revise el email."), animated: true, completion: nil)
            
        }else{
            //Inicializar usuario
            let newUser = PFUser()
            newUser.username = myUsername.text
            newUser.password = myPassword.text
            newUser.email = myEmail.text
            newUser["nombre"] = myNombre.text
            newUser["apellido"] = myApellido.text
            newUser["movil"] = myMovil.text
            
            //Mostrar activity
            myActivityIndicator.isHidden = false
            myActivityIndicator.startAnimating()
            
            //Ignorar pulsaciones del usuario, para no duplicar registros
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            //Registrarnos en segund plano
            newUser.signUpInBackground(block: { (exitoso, errorDeRegistro) in
                
                
                //Callback después de intentar regitrar
                
                //Ocultar activity
                self.myActivityIndicator.isHidden = true
                self.myActivityIndicator.stopAnimating()
                
                //Ignorar pulsaciones del usuario, para no duplicar registros
                UIApplication.shared.endIgnoringInteractionEvents()
                
                //Comprobar si existen errores
                if let error = errorDeRegistro {
                    self.present(muestraAlertVC("Atención", messageData: "Error en el registro"), animated: true, completion: nil)
                    print("Error registro: \(error.localizedDescription)")
                }else{
                    //Registrar foto si todo ha ido correctamente y acceder a la aplicación
                    self.signUpWithPhoto()
                    self.performSegue(withIdentifier: "jumpForRegisterVC", sender: self)
                    
                }
            })
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Ocultar activity
        myActivityIndicator.isHidden = true
        

        //Permitir quitar el teclado
        hideKeyboardWhenTappedAround()
        
        //Asignar gesto a la imagen
        let pulsarImagen = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImagen.isUserInteractionEnabled = true
        myImagen.addGestureRecognizer(pulsarImagen)
        
        //Redondear la imagen
        
        
    }
    
    //MARK: Utils
    func esVacia(_ text: String?) -> Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }

    func signUpWithPhoto() {
        
    }
    
    ///Permite validar un email
    func isValidEmail(_ testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}




//MARK: - Escoger imagen
//Extendemos imagePickerControllerDelegate, para poder ir a la galería
extension SARegistroTableViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    
    func pickerPhoto(){
        //Comprobamos si tenemos cámara en el dispositivo
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        }else{
            muestraLibreriaFotos()
            
        }
    }
    
    func muestraMenu(){
        let actionVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionVC.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        actionVC.addAction(UIAlertAction(title: "Usar la cámara", style: .default, handler: {Void in
            self.camaraFotos()
        }))
        
        actionVC.addAction(UIAlertAction(title: "Galería de fotos", style: .default, handler: {
            Void in
            self.muestraLibreriaFotos()}
            
            
        ))
        present(actionVC, animated: true, completion: nil)
        
    }
    
    func muestraLibreriaFotos(){
        //Creamos la variable que podrá elegir imágenes de la galería
        let selectorDeImagenes = UIImagePickerController()
        //Le damos el tipo de Galería
        selectorDeImagenes.sourceType = .photoLibrary
        //Le dejamos hacer zoom
        selectorDeImagenes.allowsEditing = true
        //Añadimos como delegado al mismo selector
        selectorDeImagenes.delegate = self
        //lo presentamos
        present(selectorDeImagenes,animated: true, completion: nil)
    }
    
    func camaraFotos(){
        //Creamos la variable que podrá elegir imágenes de la cámara
        let selectorDeImagenes = UIImagePickerController()
        //Le damos el tipo de cámara
        selectorDeImagenes.sourceType = .camera
        //Le dejamos hacer zoom
        selectorDeImagenes.allowsEditing = true
        //Añadimos como delegado al mismo selector
        selectorDeImagenes.delegate = self
        //lo presentamos
        present(selectorDeImagenes,animated: true, completion: nil)
        
    }
    
    ///Método que permite realizar comprobaciones, para diferenciar entre imagen o vídeo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Comprobamos el tipo de los datos recuperamos, confirmamos que sea una imagen
        if let imagenEscogida = info[UIImagePickerControllerOriginalImage] as? UIImage{
            //Asignamos el valor al view
            myImagen.image = imagenEscogida
        }
        
        dismiss(animated: true, completion: nil)
    }
}
