//
//  DMDAnadirProducto.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 29/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDAnadirProducto: UIViewController {
    
    //MARK:- Variables locales
    var myProducto = Producto()
    
    var datos : DatosProtocoloAlta = DatosProtocoloAlta()
    var delegado : ProtocoloAlta?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTableViewCustom: UITableView!
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myViewImagen: UIView!
    //MARK:- IBActions
    //Función que se ejecuta cuando elegimos recuperar la foto de la galería de imágenes
  
    
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        //===========================
        // Funcionalidad de la tabla
        //===========================
        //Indico que yo trataré los mensajes
        myTableViewCustom.delegate = self
        myTableViewCustom.dataSource = self
        
        //===========================
        // Funcionalidad de la imagen
        //===========================
        //Redondeamos el view de la imagen
        myViewImagen.layer.cornerRadius = 3
        //Redondemaos la imagen
        myImagen.layer.cornerRadius = 3
        //Indicamos a la imagen que puede reconocer el tacto en la pantalla
        myImagen.isUserInteractionEnabled = true
        //Necesitamos un gestor para reconocer el gesto, y después vincularlo a la imagen
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.muestraCamara))//Cuando toco, hace algo
        //Vinculamos el gestor de gestos, a la imagen
        myImagen.addGestureRecognizer(gestureRecognizer)
        
        //==============================
        // Barra de navegación
        //==============================
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(guardarDatos))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : - Utils
    func guardarDatos(){
        datos.imagen = myImagen.image
        recuperarDatosDeCeldas()
        delegado?.setDatosProtocoloAlta(datos: self.datos)
        self.navigationController?.popViewController(animated: true)
    }
    //Función que permite mostar el menú de la cámara
    func muestraCamara(){
        pickerPhoto()
    }

    func getDatos(){
        
    }
    
    

}


//Extendemos imagePickerControllerDelegate, para poder ir a la galería
extension DMDAnadirProducto : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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
    
    ///Método que permite realizar comprobaciones, para diferenciar entre imagen o vídeo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Comprobamos el tipo de los datos recuperamos, confirmamos que sea una imagen
        if let imagenEscogida = info[UIImagePickerControllerOriginalImage] as? UIImage{
            //Asignamos el valor al view
            myImagen.image = imagenEscogida
            //Asignamos el valor a la variable del producto que estamos añadiendo
            myProducto.propiedades.imagen.imagenUI = imagenEscogida
        }
        
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - DELEGADOS
//Extendemos delegate y datasource para poder tratar los métodos de la tabla
extension DMDAnadirProducto : UITableViewDelegate, UITableViewDataSource{
    
    ///Implementamos la función que devuelve el número de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    ///Implementamos la función que devuelve el número de filas para la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datos.lineas
    }
    
    // Implementamos la función que asigna un nombre para la sección
    /* func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return 1
     }*/
    
    ///Implementamos la función que devuelve la celda a reutilizar
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Creamos la celda que vamos a reutilizar
        //Debe tener el mismo nombre que el registro de la celda asignado en viewDidLoad()
        //  let cell = myTableViewCustom.dequeueReusableCell(withIdentifier: "CeldaCustom")!
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaCustom") as! DMDDetalleMejoradoCelda
        
        //Esconder separador
        cell.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, cell.bounds.size.width)
        
        //Asignar datos de la celda de la izquierda
        cell.myDatoIzq.text = String(describing: datos.datos[indexPath.row])
        cell.mylblIzq.text = String(describing: datos.etiquetas[indexPath.row])
        
        
        //Asignar datos de la celda derecha
        if ( ( datos.datos.count % 2) == 0) {
            cell.myDatoDerecha.text = String(describing: datos.datos[indexPath.row + 1])
            cell.mylblDcha.text = String(describing: datos.etiquetas[indexPath.row + 1])
        }
        //Devolvemos la celda creada
        return cell
        
        
    }
    
    ///Recorre todas las celdas de la tabla, recuperando los datos
    ///Esos datos serán regresados al anterior controller haciendo uso del protocolo [ProtocoloAlta]
    ///Edita el valor de la variable [self.datos]
    func recuperarDatosDeCeldas() {
        
        for seccion in 0 ..< myTableViewCustom.numberOfSections {
            for fila in 0 ..< myTableViewCustom.numberOfRows(inSection: 0){
                let celda = myTableViewCustom.cellForRow(at: IndexPath(row: fila, section: seccion)) as! DMDDetalleMejoradoCelda
                datos.datos[fila] = celda.myDatoIzq.text
                datos.datos[fila + 1] = celda.myDatoDerecha.text
            }
        }
        
    }
    
}

