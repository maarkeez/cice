//
//  DMDDetalleTienda.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDDetalleTiendaDelegate{
    func guardar()
}

class DMDDetalleTienda: UITableViewController {

    
    
    //MARK: - Variables locales
    var delegate : DMDDetalleTiendaDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UITextField!
    @IBOutlet weak var myTelefono: UITextField!
    
    //MARK: - IBActions
    
    @IBAction func guardarACTION(_ sender: Any) {
        let tienda = TiendaRepository.shared.new()
        
        
        
        if let imagen = myImagen.image {
            let imageData = UIImageJPEGRepresentation(imagen, 0.3)
            tienda.imagen = imageData as NSData?
            
        }
        
        tienda.nombre = myNombre.text
        tienda.telefono = myTelefono.text
        
        
        
        
        TiendaRepository.shared.save(tienda)
        
        delegate?.guardar()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        let pulsarImagen = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImagen.isUserInteractionEnabled = true
        myImagen.addGestureRecognizer(pulsarImagen)
    
    }

    //MARK: - Utils

}


//MARK: - Escoger imagen
//Extendemos imagePickerControllerDelegate, para poder ir a la galería
extension DMDDetalleTienda : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    
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
