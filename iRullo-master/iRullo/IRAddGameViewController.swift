//
//  IRAddGameViewController.swift
//  iRullo
//
//  Created by formador on 7/4/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import CoreData

protocol IRAddGameViewControllerDelegate{
    func didAddGame()
}
class IRAddGameViewController: UIViewController {

    //MARK: - Variables locales
    var manageContext : NSManagedObjectContext?
    var game : Game?
    var datePicker : UIDatePicker!
    var dateFormatter = DateFormatter()
    var irDelegate : IRAddGameViewControllerDelegate?
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myTitulo: UITextField!
    @IBOutlet weak var myBorrowedTo: UITextField!
    @IBOutlet weak var myFecha: UITextField!
    @IBOutlet weak var myEliminarBTN: UIButton!
    
    //MARK: - IBActions
    @IBAction func deleteGameACTION(_ sender: Any) {
        
        if let ctx = manageContext {
            ctx.delete(game!)
            
            //Vacio el objeto
            game = nil
            
            //Actualizamos en el delegado
            irDelegate?.didAddGame()
            //Mostramos el controlador
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func didChangeSwitchACTION(_ sender: UISwitch) {
        if sender.isOn {
            myBorrowedTo.isEnabled = true
            myFecha.isEnabled = true
            myFecha.text = dateFormatter.string(from: Date())
        }else{
            myBorrowedTo.isEnabled = false
            myFecha.isEnabled = false
            myFecha.text = ""
            myBorrowedTo.text = ""

        }
    }
   
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //--------------------------------------
        //-- Imagen
        //--------------------------------------
        myImagen.isUserInteractionEnabled = true
        let gesto = UITapGestureRecognizer(target: self, action: #selector(pickerPhoto))
        myImagen.addGestureRecognizer(gesto)
        
        //--------------------------------------
        //-- Teclado
        //--------------------------------------
        //Va a ser subido y bajado colocando de manera visible además el text field donde estemos escribiendo
        
        //Nos suscribimos a la notificación del teclado para editar la acción al mostrarlo
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        //Nos suscribimos a la notificación del teclado para editar la acción al ocultarlo
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        //--------------------------------------
        //-- Formato de las fechas
        //--------------------------------------
        dateFormatter.dateFormat = "dd/MM/yyyy"

        //--------------------------------------
        //-- Datepicker
        //--------------------------------------
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 210, width: 320, height: 216))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        myFecha.inputView = datePicker
        
        //--------------------------------------
        //-- Lógica Añadir/Editar
        //--------------------------------------
        if game == nil {
            //Añadir
            self.title = "Nuevo juego"
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
            
            //Ocultar el botón de eliminar
            myEliminarBTN.isHidden = true
            
            //Marcar como prestado
            mySwitch.isOn = true
            //Marcar la fecha como la actual
            myFecha.text = dateFormatter.string(from: Date())
            
        }else{
            //Editar
            self.title = "Editando juego"
            
            //Recuperar la información a partir del juego
            mySwitch.isOn = (game?.borrowed)!

            if let tituloJuego = game?.title {
                myTitulo.text = tituloJuego
            }
            
            if let quien = game?.borrowedTo {
                myBorrowedTo.text = quien
            }

            if let fecha = game?.borrowedDate as Date?{
                myFecha.text = dateFormatter.string(from: fecha)
            }
            
            if let imagenData = game?.image as Data? {
                myImagen.image = UIImage(data: imagenData)
            }

        }
        
        if !mySwitch.isOn {
            myBorrowedTo.isEnabled = false
            myFecha.isEnabled = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Siempre que esté editando y de a back, guardo
        if(game != nil){
            saveGame()
        }
    }
    
    //MARK: - Utils
    
    ///Esta función mueve la vista tantos pixeles como mida el teclado de alto
    ///para no perder el textfield en el que estamos escribiendo
    func keyboardWillShow(_ notification : Notification){
        //Información del usuario
        let info = notification.userInfo!
        
        // Frame para el teclado
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        //Tiempo que tardará en mostrarse
        let keyboardTime = (info[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).doubleValue
        
        //Animar con tiempo de animación
        UIView.animate(withDuration: keyboardTime) {
            //Levantamos la vista tantos puntos en Y como sube la posición del teclado
            self.view.frame.origin.y = -(keyboardFrame.height)
        }
        
    }
    
    ///Este método coloca la vista en la posición 0 de altura, es decir, en su posición original
    func keyboardWillHide(_ notification : Notification){
        //Información del usuario
        let info = notification.userInfo!
        
        //Tiempo que tardará en mostrarse
        let keyboardTime = (info[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).doubleValue
        
        //Animar con tiempo de animación
        UIView.animate(withDuration: keyboardTime) {
            //Movemos hacia la posición inicial la vista
            self.view.frame.origin.y = 0
        }
    }
    
    ///Oculta el teclado al puslar sobre cualquier punto de la vista
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    ///Escribe la fecha en el textfield a partir de la fecha seleccionada en el datepicker
    func datePickerChanged(_ picker : UIDatePicker){
        myFecha.text = dateFormatter.string(from: picker.date)
    }
    
    ///Sale de la ventana sin guardar
    func cancelButtonPressed(){
        dismiss(animated: true, completion: nil)
    }
    
    ///Guarda el juego y sale de la ventana
    func saveButtonPressed(){
        saveGame()
        dismiss(animated: true, completion: nil)
    }
    
    ///Guarda el juego haciendo uso de CoreData
    func saveGame(){
        
        if let ctx = manageContext {
            
            var editedGame : Game?
            
            if game == nil {
                //Nuevo objeto
                editedGame = Game(context: ctx)
                //Fecha creado
                editedGame?.dateCreated = NSDate()
            }else {
                //Es una edición, el objeto lo envía otro controlador
                editedGame = game
            }
            
            //Desempaquetamos
            if let editedGameDes = editedGame{
                

                editedGameDes.borrowed = self.mySwitch.isOn
                editedGameDes.title = self.myTitulo.text
                
                
                if let imagenData = myImagen.image{
                    //Guardar comprimiendo a la mitad como NSData
                    editedGameDes.image = UIImageJPEGRepresentation(imagenData, 0.5) as NSData?
                }
                
                if editedGameDes.borrowed {
                    editedGameDes.borrowedTo = self.myBorrowedTo.text?.uppercased()
                    editedGameDes.borrowedDate = dateFormatter.date(from: self.myFecha.text!) as NSDate?
                }else{
                    editedGameDes.borrowedTo = nil
                    editedGameDes.borrowedDate = nil
                }
                
                do{
                    try ctx.save()
                    irDelegate?.didAddGame()
                }catch let error{
                    print("Error: \(error.localizedDescription) \n al guardar los datos.")
                }
            }
            
        }
    }
}


//MARK: - Delegado picker fotos
extension IRAddGameViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
            myImagen.image = imagenData
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
