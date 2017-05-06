//
//  PostSocialNetwork.swift
//  App_SocialNetwork
//
//  Created by cice on 31/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit
//Para poder acceder a las redes sociales de Preferencias Generales del IPhone
import Social


class PostSocialNetwork: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var myText: UITextView!
    @IBOutlet weak var myImage: UIImageView!
    
    //MARK: - IBActions
    @IBAction func showCamera(_ sender: Any) {
        pickerPhoto()
    }
    
    ///Post en facebook
    @IBAction func showFacebook(_ sender: Any) {

        //Comprobar si tengo habilitado Facebook
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            let postFacebook = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            postFacebook?.setInitialText(myText.text)
            postFacebook?.add(myImage.image)
            postFacebook?.add(URL(string: "http://www.andresocampo.com"))
            present(postFacebook!, animated: true, completion: nil)
            limpiarDatos()
        }else{
            present( showAlert("Sin conexión", mensaje: "Actualmente no tiene conifgurada cuenta de facebook. Inicie sesión para compartir desde ajustes del sistema.", tituloAccion: "Aceptar"), animated: true, completion: nil)
           
        }
        
    }
    
    ///Post en twitter
    @IBAction func showTwitter(_ sender: Any) {
        //Comprobar si tengo habilitado Facebook
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let postTwitter = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            postTwitter?.setInitialText(myText.text)
            postTwitter?.add(myImage.image)
            postTwitter?.add(URL(string: "http://www.andresocampo.com"))
            present(postTwitter!, animated: true, completion: nil)
            limpiarDatos()
        }else{
            present( showAlert("Sin conexión", mensaje: "Actualmente no tiene conifgurada cuenta de twitter. Inicie sesión para compartir desde ajustes del sistema.", tituloAccion: "Aceptar"), animated: true, completion: nil)
            
        }
    }
    
    ///Permite compartir la info entre aplicaciones
    @IBAction func showActivity(_ sender: Any) {
        
        let text = myText.text
        let image = myImage.image
        let URLpost = "http://www.andresocampo.com"
        
        
        // set up activity view controller
        let activityViewController = UIActivityViewController(activityItems: [ text! , image!, URLpost], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [ UIActivityType.postToTwitter, UIActivityType.postToFacebook ]
        
        present(activityViewController, animated: true, completion: nil)
        
        limpiarDatos()
        
    }
    
    
    @IBAction func showAlertAction(_ sender: Any) {
        showAlert("Enhorabuena!", mensaje: "Este botón no vale para nada", tituloAccion: ":)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Utils
    func limpiarDatos(){
        myText.text = "¿Qué es Lorem Ipsum? Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas Letraset, las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum."
        myImage.image = #imageLiteral(resourceName: "placeholder")
    }
    
    
}


//MARK: - Delegado picker fotos
extension PostSocialNetwork : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func pickerPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        }else{
            muestraLibreriaFotos()
        }
    }
    
    func muestraMenu(){
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let camara = UIAlertAction(title: "Cámara", style: .default) { _ in
            self.muestraCamara()
        }
        
        let libreria = UIAlertAction(title: "Librería", style: .default) { _ in
            self.muestraLibreriaFotos()
        }
        
        alertVC.addAction(cancelar)
        alertVC.addAction(camara)
        alertVC.addAction(libreria)
        
        self.present(alertVC, animated: true, completion: nil)
        
    }
    
    func muestraCamara(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func muestraLibreriaFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imagenData = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImage.image = imagenData
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
