//
//  DMDDetalleProducto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDDetalleProductoDelegate{
    func guardar()
}

class DMDDetalleProducto: UITableViewController {

    
    //MARK: - Variables locales
    var delegate : DMDDetalleProductoDelegate?
    
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
    @IBAction func guardarACTION(_ sender: AnyObject) {
        guardar()
        delegate?.guardar()
        self.navigationController?.popViewController(animated: true)
    }

    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    
        myTalla.delegate = self
        myTalla.dataSource = self
        
        let pulsarImagen = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImagen.isUserInteractionEnabled = true
        myImagen.addGestureRecognizer(pulsarImagen)

    }

    //MARK: - Utils
    func guardar(){
        let producto = ProductoRepository.shared.new()
        
        producto.codigoBarras = myCodigoBarras.text ?? ""
        producto.codigoEmpresa = myCodigoEmpresa.text ?? ""
        producto.talla = CONSTANTES.TALLA.LISTADO[myTalla.selectedRow(inComponent: 0)]
        
       
        producto.precioCoste = Float(myCoste.text!) ?? 0.0
        producto.pvp = Float(myPVP.text!) ?? 0.0
        producto.descuento = Float(myDescuento.text!) ?? 0.0
        
        if let imagen = myImagen.image {
            let imageData = UIImageJPEGRepresentation(imagen, 0.3)
            producto.imagen = imageData as NSData?
            
        }
        
        producto.nombre = myNombre.text
        producto.descripcion = myDescripcion.text
        
        
        
        
        ProductoRepository.shared.save(producto)
        
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

