//
//  DMDTablaDinamicaCG.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDTablaDinamicaCGDelegate {
    func setData(_ data: DMDTablaDataCG)
    func getData() -> DMDTablaDataCG
}

class DMDTablaDinamicaCG: UIViewController {
    
    //MARK: - Variables locales
    var data : DMDTablaDataCG!
    var indexItemSelected : Int?
    //Textfield activo para hacer scroll
    var activeField: UITextField?
    
    var delegate : DMDTablaDinamicaCGDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myContainer: UIView!
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    @IBOutlet weak var mySearch: UISearchBar!
    @IBOutlet weak var myTable: UITableView!
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
    }
    
    //MARK: - Life VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Acciones por defecto para el View Controller
        registerForKeyboardNotifications()
        hideKeyboardWhenTappedAround()
        mostrarMenu(myMenuBTN)
        
        //Obtenemos los datos del delegado
        data = delegate?.getData()
        
        // Modificar UI
        mySearch.barTintColor = CONSTANTES.COLOR_AZUL.TAB_NAV_BAR
        mySearch.alpha = 0.7
        if !data.showSearchBar {
            hideSearchBar()
        }
        
        //Opciones para la tabla
        myTable.dataSource = self
        myTable.delegate = self
        //myTable.separatorStyle = .none
        myTable.estimatedRowHeight = 40
        myTable.rowHeight = UITableViewAutomaticDimension
        
        //Registrar las celdas para reutilizarlas
        myTable.register(UINib(nibName: "CeldaTexto", bundle: nil), forCellReuseIdentifier: "CeldaTexto")
        myTable.register(UINib(nibName: "CeldaTextoLargo", bundle: nil), forCellReuseIdentifier: "CeldaTextoLargo")
        myTable.register(UINib(nibName: "CeldaFecha", bundle: nil), forCellReuseIdentifier: "CeldaFecha")
        myTable.register(UINib(nibName: "CeldaPerfil", bundle: nil), forCellReuseIdentifier: "CeldaPerfil")
        myTable.register(UINib(nibName: "CeldaCodigoBarras", bundle: nil), forCellReuseIdentifier: "CeldaCodigoBarras")
        myTable.register(UINib(nibName: "CeldaSelector", bundle: nil), forCellReuseIdentifier: "CeldaSelector")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.setData(data)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Utils
    
    ///Oculta la barra de búsqueda de manera animada.
    func hideSearchBarAnimated(){
        UIView.animate(withDuration: 0.2, animations: {
            self.hideSearchBar()
        })
    }
    
    ///Oculta la barra de búsqueda, recoloca la tabla ocupando toda la vista
    func hideSearchBar() {
        mySearch.isHidden = true
        myTable.frame = CGRect(x: 0, y: 0, width: myContainer.frame.width, height: myContainer.frame.height)
    }
    
    ///Muestra la barra de búsqueda y desplaza la tabla hacia abajo
    func showSearchBarAnimated(){
        UIView.animate(withDuration: 0.2, animations: {
            self.mySearch.isHidden = false
            self.myTable.frame = CGRect(x: 0, y: 44, width: self.myContainer.frame.width, height: self.myContainer.frame.height)
        })
    }
    
    ///Guarda el índice del elemento que hemos seleccionado para futuras operaciones
    /// en los delegados
    func didSelectItem(_ index: Int){
        indexItemSelected = index
    }
    
    /// Obtiene el delegado para la celda en función del indice previamente guardado.
    func getSelectedItem() -> DMDCeldaCGDelegate?{
        if let index = indexItemSelected{
            return data.listaItems[index]
        }
        return nil
    }
    
    /// Actualiza el elemento seleccionado dentro del array de información interno
    /// y repinta la tabla
    func updateSeledtedItem(_ item: DMDCeldaCGDelegate){
        if let index = indexItemSelected{
            data.listaItems[index] = item
            myTable.reloadData()
        }
    }
}

//MARK: - Extensión para mostrar el listado de productos
extension DMDTablaDinamicaCG: UITableViewDelegate, UITableViewDataSource{
    
    ///Obtiene una celda a partir del elemento que se corresponde dentro del array de datos.
    ///Las celdas no se marcan al ser seleccionadas.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda =  data.getCelda(indexPath.row, tabla: myTable)
        celda.selectionStyle = .none
        return celda
    }
    
    ///Recuperar el numero de secciones de los datos de configuración
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.getNumberOfSections()
    }
    
    ///Recuperar el número de secciones de los datos de configuración
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.numberOfRowsInSection()
    }
    
    ///Recupera la altura de la celda para el dato correspondiente en el array de datos
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if data.listaItems[indexPath.row] is DMDCeldaTextoLargo {
            return UITableViewAutomaticDimension
        }
        return data.getHeightForRowAt(indexPath.row)
    }
    
    ///Recupera las acciones de la celda para el dato correspondiente en el array de datos.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return data.getAcciones(indexPath.row)
    }
    
    ///Controlar las acciones al hacer scroll.
    /// Si se hace el scroll máximo por arriba se muestra la barra de búsqueda.
    /// en caso contrario se oculta dicha barra si está siendo mostrada.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if data.showSearchBar{
            if(scrollView.contentOffset.y <= 0 ){
                if(mySearch.isHidden){
                    showSearchBarAnimated()
                }
            }else{
                if(!mySearch.isHidden){
                    hideSearchBarAnimated()
                }
            }
        }
    }
    
    ///Acciones al seleccionar una celda. Cada acción depende del tipo de dato que fue seleccionado.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem(indexPath.row)
        
        if getSelectedItem() is DMDCeldaFecha {
            showCalendar()
        }
        
        if getSelectedItem() is DMDCeldaCodigoBarras {
            showLectorCodigoBarras()
        }
        
        if getSelectedItem() is DMDCeldaPerfil {
            showMenuCeldaPerfil()
        }
        
        if getSelectedItem() is DMDCeldaSelector {
            showDMDSelector(self)
        }
        
        if getSelectedItem() is DMDCeldaTextoLargo {
            showDMDTextoLargo(self)
        }
    }
}

//MARK: - Extensión para tratar la celda perfil
extension DMDTablaDinamicaCG {
    
    ///Muestra las acciones posibles a realizar sobre un listado de alertas.
    func showMenuCeldaPerfil(){
        //Controlador
        let actionVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //Cancelar
        actionVC.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        //Editar imagen de perfil
        actionVC.addAction(UIAlertAction(title: "Imagen perfil", style: .default, handler: {Void in
            self.pickerPhoto()
        }))
        
        // Editar nombre
        actionVC.addAction(UIAlertAction(title: "Nombre", style: .default, handler: {
            Void in
            self.editNombrePerfil()
        }))
        
        //Mostrar controlador
        present(actionVC, animated: true, completion: nil)
        
    }
    
    ///Permite editar  el nombre de perfil.
    /// Se muestra una alert con un campo de texto para modificarlo
    func editNombrePerfil(){
        
        //Campo de texto para el nombre
        var inputTextField: UITextField?
        
        // Controlador
        let alert = UIAlertController(title: "Nombre", message: "Modifique su nombre de usuario", preferredStyle: UIAlertControllerStyle.alert)
        
        //Acciones
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.cancel,handler: nil))
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            //Si he seleccionado celda de perfil, cambio el nombre.
            if let item = self.getSelectedItem() as? DMDCeldaPerfil {
                item.nombre = inputTextField?.text
                self.updateSeledtedItem(item)
            }
        }))
        
        //Configuracion del controlador
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Nombre..."
            inputTextField = textField
        })
        
        //Presentar controlador
        self.present(alert, animated: true, completion: nil)
    }
}


//MARK: - Extensión para mostrar el calendario
extension  DMDTablaDinamicaCG: DMDCalendarioDelegate {
    
    ///Muestra un nuevo view controller que permite seleccionar fecha y hora.
    func showCalendar(){
        let calendarVC = self.storyboard?.instantiateViewController(withIdentifier: "DMDCalendario") as! DMDCalendario
        calendarVC.delegate = self
        calendarVC.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    ///Fecha seleccionada
    func didSelectDate(_ date: Date){
        if let item = getSelectedItem() as? DMDCeldaFecha {
            item.fecha = date
            updateSeledtedItem(item)
        }
    }
    
    ///Permite indicar si se quiere o no elegir la hora
    ///TODO: Hacer parametrizable
    func isHoursNeeded() -> Bool {
        return true
    }
}

//MARK: - Extensión para tratar con los campos de texto
extension DMDTablaDinamicaCG: UITextFieldDelegate{
    
    
    ///Función del delegado, al seleccionar un campo de texto se guarda
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    ///Función del delegado, al dejar de edigar un campo de texto se vacía.
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeField = nil
    }
    
    ///Función que permite registrar como observador al view controller y activar el scroll automático sobre la tabla.
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    /// Muestra el teclado, es llamada desde el centro de notificaciones.
    func keyboardWasShown(note: NSNotification) {
        
        //Obtener el tamaño del teclado
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            //Tamaño de la tabla
            var frame = myTable.frame
            
            //Recalcular el tamaño de la tabla restando el tamaño del teclado
            frame.size.height -= keyboardSize.height
            
            //Reasignar el tamaño a la tabla
            myTable.frame = frame
            
            //Si he seleccionado algún campo de texto previamente
            if activeField != nil {
                // Hacer scroll hasta el campo activo
                let rect = myTable.convert((activeField?.bounds)!, from: activeField)
                myTable.scrollRectToVisible(rect, animated: false)
            }
        }
    }
    
    /// Oculta el teclado, es llamado desde el centro de notificaciones.
    func keyboardWillBeHidden(note: NSNotification) {
        
        //Obtener el tamaño del teclado
        if let keyboardSize = (note.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //Ampliar de nuevo el tamaño de la tabla sumando el tamaño del teclado
            var frame = myTable.frame
            frame.size.height += keyboardSize.height
            myTable.frame = frame
        }
    }
    
}

//MARK: - Delegado para escaner
extension DMDTablaDinamicaCG : DMDEscanerQRDelegate{
    
    func showLectorCodigoBarras(){
        let escanerQR = self.storyboard?.instantiateViewController(withIdentifier: "EscanerQR") as! DMDEscanerQR
        escanerQR.delegate = self
        escanerQR.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(escanerQR, animated: true)
    }
    
    func soloUno() -> Bool {
        return true
    }
    
    ///Recupera los datos escaneados en la vista del escaner
    func getCodigosEscaneados(_ escanerQR: DMDEscanerQR, codigos: [String]) {
        
        let itemSelected = getSelectedItem()
        
        if let item = itemSelected as? DMDCeldaCodigoBarras {
            if codigos.count > 0 {
                item.codigoBarras = codigos[0]
                updateSeledtedItem(item)
            }
        }
    }
}


//MARK: - Escoger imagen
//Extendemos imagePickerControllerDelegate, para poder ir a la galería
extension DMDTablaDinamicaCG : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    
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
            
            
            if let item = getSelectedItem() as? DMDCeldaPerfil {
                item.imagen = imagenEscogida
                updateSeledtedItem(item)
            }
            
        }
        
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Extensión para tratar el selector
extension DMDTablaDinamicaCG: DMDSelectorDelegate{
    
    func didSelect(_ indexSelected: Int?){
        if let item = getSelectedItem() as? DMDCeldaSelector{
            if let indice = indexSelected {
                item.indiceSeleccionado = indice
                updateSeledtedItem(item)
            }
        }
    }
    
    func getOptions() -> [String]{
        if let item = getSelectedItem() as? DMDCeldaSelector {
            return item.opciones
        }
        return []
    }
}

//MARK: - Extensión para tratar el texto largo
extension DMDTablaDinamicaCG: DMDTextoLargoDelegate{
    
    func setTexto(_ texto: String){
        if let item = getSelectedItem() as? DMDCeldaTextoLargo{
            item.texto = texto
            updateSeledtedItem(item)
        }
    }
    
    func getTexto() -> String{
        if let item = getSelectedItem() as? DMDCeldaTextoLargo{
            return item.texto
        }
        return "Escriba su texto aqui..."
    }
    
    func getTitulo() -> String{
        if let item = getSelectedItem() as? DMDCeldaTextoLargo{
            return item.titulo
        }
        return ""
    }
}


