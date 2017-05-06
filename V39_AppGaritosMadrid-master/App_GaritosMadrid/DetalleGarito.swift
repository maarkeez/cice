//
//  DetalleGarito.swift
//  App_GaritosMadrid
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit


protocol DetalleGaritoDelegate{
    func detalleBarEtiquetado(_ detalleVC: DetalleGarito, barEtiquetado: Garito)
}

class DetalleGarito: UIViewController {

    
    //MARK: - Variables locales
    var garito : Garito?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPIcker: UIImageView!
    @IBOutlet weak var myLatitud: UILabel!
    @IBOutlet weak var myLongitud: UILabel!
    @IBOutlet weak var myCalle: UILabel!
    @IBOutlet weak var mySalvarBTN: UIBarButtonItem!
    
    var delegate : DetalleGaritoDelegate?
    
    
    //MARK: - IBAction
    @IBAction func cancelar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mySalvarAction(_ sender: Any) {
        if let imageData = myImagenPIcker.image{
            let randomNameImage = UUID().uuidString.appending(".jpg")
            
            if let customUrl = GaritoRepository.shared.dataBaseImagenUrl()?.appendingPathComponent(randomNameImage){
                if let imageDataDesempaquetado = UIImageJPEGRepresentation(imageData, 0.3){
                    
                    do{
                        try imageDataDesempaquetado.write(to: customUrl)

                    }catch{
                        print("Error salvando datos")
                    }
                }
            }
            
            
            garito = Garito(direccion: myCalle.text!, latitud: Double(myLatitud.text!)!, longitud: Double(myLongitud.text!)!, imagen: randomNameImage)
            
            if let infoGarito = garito  {
                delegate?.detalleBarEtiquetado(self, barEtiquetado: infoGarito)
            }
            
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        myImagenPIcker.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImagenPIcker.addGestureRecognizer(tap)
        
        setIBOutlets()
        
    }
    
    //MARK: - Utils
    func setIBOutlets(){
        myLatitud.text = String(format: "%.8f", (garito?.coordinate.latitude)!)
        myLongitud.text = String(format: "%.8f", (garito?.coordinate.longitude)!)
        myCalle.text = garito?.direccion
    }
}

//MARK: - Delegado picker fotos
extension DetalleGarito : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
            myImagenPIcker.image = imagenData
            mySalvarBTN.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        mySalvarBTN.isEnabled = false
        dismiss(animated: true, completion: nil)
    }
}
