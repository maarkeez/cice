//
//  DMDNuevaTarea.swift
//  App_BarLogin
//
//  Created by cice on 10/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDNuevaTarea: UITableViewController {

    //MARK: - Variables locales
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myUsername: UILabel!
    @IBOutlet weak var myFecha: UILabel!
    @IBOutlet weak var myTexto: UITextView!
   
    @IBOutlet weak var myOcultarImagen: UIButton!
    
    @IBOutlet weak var myImagenAdjunta: UIImageView!
    
    //MARK: - IBActions
    @IBAction func accionOcultarImagen(_ sender: AnyObject) {
        myOcultarImagen.isHidden = true
        myImagenAdjunta.isHidden = true
    }
    
    
    
    @IBAction func cerrarVentana(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Crear toolbar
        let toolbar = getToolbar()
        //Asociar la toolbar al texto
        myTexto.inputAccessoryView = toolbar
        
        //Hacer la tabla dinámica
        setTablaDinamica()
        
        myTexto.delegate = self
        
        //oculto el botón con la X
        myOcultarImagen.isHidden = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.bajarTeclado))
        tableView.addGestureRecognizer(gestureRecognizer)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Indicamos al texto como primer elemento
        //así salta el teclado
        myTexto.becomeFirstResponder()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            //Texto - Hacemos la celda dinámica para el texto:
            return UITableViewAutomaticDimension
            
        default:
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    //MARK: - Utils
    
    func setTablaDinamica(){
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func bajarTeclado(){
        myTexto.resignFirstResponder()
    }
    
    /// Esta funcion crea una barra al pie del view con dos botones
    /// - returns: toolbar Barra creada
    func getToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44  ))
        let camara = UIBarButtonItem(image: UIImage(named: "camara"),
                                     style: .done,
                                     target: self,
                                     action: #selector(self.pickerFoto))
        let guardar = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(self.guardarDatos))
        let barraFlexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil  )
        
        
        toolbar.items = [camara, barraFlexible, guardar]
        
        toolbar.barTintColor = CONSTANTES.COLOR.CASI_NEGRO
        toolbar.tintColor = CONSTANTES.COLOR.AMARILLO
        
        return toolbar
    }
    
    func pickerFoto(){
        muestraMenu()
    }
    
    func guardarDatos(){
        if myTexto.text != "" && myImagenAdjunta.image != nil{
            let imageData = UIImageJPEGRepresentation(myImagenAdjunta.image!, 0.3)
            tareasManager.tareas.append([CONSTANTES.USER_DEFAULTS.KEY_DESCRIPCION_TAREA : myTexto.text as String ])
            tareasManager.fotoTarea.append([CONSTANTES.USER_DEFAULTS.KEY_IMAGEN_TAREA : imageData! as Data])
            //tareasManager.guardarTareas()
            dismiss(animated: true, completion: nil)
        }
        
        present(getAlertVC("ERROR!", mensaje: "Rellena toda la información.", tituloAccion: "Aceptar"), animated: true, completion: nil)
    }

}



extension DMDNuevaTarea : UITextViewDelegate{
    
    //Cuando el texto esté cambiando, se actualice y vaya mostrando lo último escrito
    func textViewDidChange(_ textView: UITextView) {
        //Distancia actual de la tabla
        let currentOffSet = tableView.contentOffset
        
        //Quita las animaciones para la tabla para que no vibre la imagen al escribir
        UIView.setAnimationsEnabled(false)
        
        //Comenzar a actualizar la tabla
        tableView.beginUpdates()
        //Termina la actualización
        tableView.endUpdates()
        //vuelvo a establecer el offset de la tabla
        tableView.setContentOffset(currentOffSet, animated: false)
        
        
        
    }
    
    
}




//Extendemos imagePickerControllerDelegate, para poder ir a la galería
extension DMDNuevaTarea : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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
            self.camaraFotos()
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
            myImagenAdjunta.image = imagenEscogida
            myOcultarImagen.isHidden = false
        }
        
        dismiss(animated: true, completion: nil)
    }
}








