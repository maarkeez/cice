//
//  ViewController.swift
//  intro.user.default
//
//  Created by cice on 27/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK : - Variables locales
    
    //MARK : - IBOutlets
    
    @IBOutlet weak var myNombre: UITextField!
    @IBOutlet weak var myApellido: UITextField!
    @IBOutlet weak var myDireccion: UITextField!
    @IBOutlet weak var myTelefono: UITextField!
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myFechaActualizacion: UILabel!
    
    //MARK : - IBActions
    @IBAction func guardarDatos(_ sender: AnyObject) {
      
        
        if myNombre.text != ""             && myApellido.text != ""
            && myDireccion.text != ""             && myTelefono.text != ""{
            
            prefs.set(myNombre.text, forKey: CONSTANTES.NOMBRE)
            prefs.set(myApellido.text, forKey: CONSTANTES.APELLIDO)
            prefs.set(myDireccion.text, forKey: CONSTANTES.DIRECCION)
            prefs.set(myTelefono.text, forKey: CONSTANTES.TELEFONO)
            prefs.set(myFechaActualizacion.text, forKey: CONSTANTES.FECHA_ACTUALIZACION)
            //Recuperamos la imagen, y la comprimimos como en instagram
            if let imagen = myImagen.image{
                let imagenData = UIImageJPEGRepresentation(imagen, 0.1)
                prefs.set(imagenData, forKey: CONSTANTES.IMAGEN_DATA)
            }
            //Recuperamos la fecha actual
            let acutalizacion = Date()
            prefs.set(acutalizacion, forKey: CONSTANTES.FECHA_ACTUALIZACION)
            
            present(getPopUp(titulo: "Guardado OK", mensaje: "Se ha guardado todo OK", mensajeBoton: "OK"), animated: true, completion:limpiarDatos
            )
        }else{
            present(getPopUp(titulo: "ERROR", mensaje: "Es necesario que rellene todos los campos", mensajeBoton: "OK"), animated: true, completion: nil)
        }
        
        
    }
    @IBAction func actualizarDatos(_ sender: AnyObject) {
        getDatos()
    }
    
    
    
    //MARK : - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //===========================
        // Funcionalidad de la imagen
        //===========================
        //Indicamos a la imagen que puede reconocer el tacto en la pantalla
        myImagen.isUserInteractionEnabled = true
        //Necesitamos un gestor para reconocer el gesto, y después vincularlo a la imagen
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.muestraCamara))//Cuando toco, hace algo
        //Vinculamos el gestor de gestos, a la imagen
        myImagen.addGestureRecognizer(gestureRecognizer)
        
        //Imprimimos nuetra aplicación por la salida estándar
        print("mifichero" + Bundle.main.bundleIdentifier!)
        print(Bundle.main)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : - Utils
    func muestraCamara(){
        pickerPhoto()
    }
    
    func limpiarDatos(){
        myNombre.text = ""
        myApellido.text = ""
        myTelefono.text = ""
        myDireccion.text = ""
        myImagen.image = UIImage(named: "placeholder")
        // Para vaciar el plist de memoria sólo se puede hacer por código:
        //UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    func getDatos(){
        myNombre.text = prefs.object(forKey: CONSTANTES.NOMBRE) as? String
        myApellido.text = prefs.object(forKey: CONSTANTES.APELLIDO) as? String
        myTelefono.text = prefs.object(forKey: CONSTANTES.TELEFONO) as? String
        myDireccion.text = prefs.object(forKey: CONSTANTES.DIRECCION) as? String
        
        if let imagenData = prefs.data(forKey: CONSTANTES.IMAGEN_DATA){
            myImagen.image = UIImage(data: imagenData)

        }
        
        
        let fecha = prefs.object(forKey: CONSTANTES.FECHA_ACTUALIZACION) as! Date 
            
       
        myFechaActualizacion.text = DateToString( date: fecha)
    }
    
    
}

//Extendemos imagePickerControllerDelegate, para poder ir a la galería
extension ViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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
        actionVC.addAction(UIAlertAction(title: "Tomar fotos", style: .default, handler: {Void in
            self.muestraCamara()
        }))
        
        actionVC.addAction(UIAlertAction(title: "Escoge de la libreria", style: .default, handler: {
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
    
    //Método que permite realizar comprobaciones, para diferenciar entre imagen o vídeo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Comprobamos el tipo de los datos recuperamos, confirmamos que sea una imagen
        if let imagenEscogida = info[UIImagePickerControllerOriginalImage] as? UIImage{
            //Asignamos el valor al view
            myImagen.image = imagenEscogida
        }
        
        dismiss(animated: true, completion: nil)
    }
}












































