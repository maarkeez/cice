//
//  DMDDetalleProducto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDDetalleProducto: UITableViewController {

    
    //MARK: - Variables locales
    
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCodigoEmpresa: UITextField!
    @IBOutlet weak var myCodigoBarras: UITextField!
    @IBOutlet weak var myTalla: UIPickerView!
    @IBOutlet weak var myCoste: UITextField!
    @IBOutlet weak var myDescuento: UITextField!
    @IBOutlet weak var myPVP: UITextField!
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombre: UITextField!
    @IBOutlet weak var myDescripcion: UITextView!

    
    //MARK: - IBActions
    @IBAction func guardarACTION(_ sender: Any) {
        guardar()
        dismiss(animated: true, completion: nil)
    }

    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    
        myTalla.delegate = self
        myTalla.dataSource = self
        

    }

    //MARK: - Utils
    func guardar(){
        
    }
}


//MARK: - PickerView Tallas
extension DMDDetalleProducto : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CONSTANTES.TALLA.LISTADO.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CONSTANTES.TALLA.LISTADO[row]
    }
}

//MARK: - Escoger imagen
//Extendemos imagePickerControllerDelegate, para poder ir a la galería
extension DMDDetalleProducto : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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

