//
//  DMDListaRecibirPedido.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDListaRecibirPedidoDelegate {
    func setPedidoProductos(_ lista: [PedidoProductos])
}

class DMDListaRecibirPedido: UIViewController {
    
    //MARK: - Variables locales
    var listadoProductos = [Producto]()
    var cantidades = [String:Int]()
    var isToolbarHidden : Bool?
    
    var delegate : DMDListaRecibirPedidoDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTable: UITableView!
    
    //MARK: - IBActions
    @IBAction func escanearACTION(_ sender: Any) {
        let escanerVC =  storyboard?.instantiateViewController(withIdentifier: "EscanerQR") as! DMDEscanerQR
        escanerVC.delegate = self
        navigationController?.pushViewController(escanerVC, animated: true)
        
    }
    
    
    ///Guardar la lista de productos como inventario a fecha actual
    @IBAction func confirmarACTION(_ sender: Any) {
        delegate?.setPedidoProductos(getPedidoProductos())
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func paraMasTardeACTION(_ sender: Any) {
        //TODO: Implementar
        
    }
    
    @IBAction func cancelarACTION(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegados
        myTable.dataSource = self
        myTable.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isToolbarHidden = isToolbarHidden!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Guardamos el estado actual de la barra de navegación
        isToolbarHidden = (navigationController?.isToolbarHidden)!
        //Mostramos la barra inferior para poder acceder a los botones de las acciones
        navigationController?.isToolbarHidden = false
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///Permite aumentar x cantidad para un producto en el listado interno
    func addProducto(_ producto: Producto, cantidad: Int){
        var existe = false
        
        //Recorrer la lista de productos
        for productoLista in listadoProductos {
            
            //Si se trata del producto a añadir
            if productoLista.id == producto.id {
                
                //Marcamos el producto como existente
                existe = true
                
                //Comprobar si tiene cantidad asociada
                if cantidades["\(productoLista.id)"] != nil {
                    //Si tiene alguna cantidad asociada, sumamos la nueva cantidaad
                    cantidades["\(productoLista.id)"] = cantidades["\(productoLista.id)"]! + cantidad
                }else{
                    //Si no tiene cantidad, se la asignamos
                    cantidades["\(productoLista.id)"] = cantidad
                }
            }
        }
        
        if(!existe){
            //Si no existe, lo añadimos y le asignamos la cantidad.
            listadoProductos.append(producto)
            cantidades["\(producto.id)"] = cantidad
        }
    }
    
    func getPedidoProductos() -> [PedidoProductos]{
        var pedidoProductos = [PedidoProductos]()
        
        for producto in listadoProductos {
            
            if let cantidadFloat = cantidades["\(producto.id)"] {
                let cantidad = Float(cantidadFloat)
                
                let pedidoProducto = PedidoProductos(id: nil,
                                                     producto: producto,
                                                     precioCoste: producto.propiedades?.precioCoste,
                                                     precioVentaPublico: producto.propiedades?.precioVentaPublico,
                                                     cantidad: cantidad,
                                                     inventario: nil,
                                                     pedido: nil)
                
                pedidoProductos.append(pedidoProducto)
            }
        }
        
        return pedidoProductos
    }
}

//MARK: - Extensión para mostrar el listado de productos
extension DMDListaRecibirPedido: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //Recuperar el producto para generar la celda
        let producto = listadoProductos[indexPath.row]
        
        //Crear la celda
        let celda = tableView.dequeueReusableCell(withIdentifier: "DMDListaRecibirPedidoCelda") as! DMDListaRecibirPedidoCelda
        
        //Celda - Imagen
        if let imagenString = producto.propiedades?.imagenString {
            celda.myImagen.image =  Utils.shared.getImagen(imagenString)
        }
        
        //Celda - nombre
        if let nombre = producto.nombre {
            celda.myNombre.text = nombre
        }
        
        //Celda - cantidad
        let cantidad = cantidades["\(producto.id)"]
        
        if let cantidadDes = cantidad {
            celda.myCantidad.text = "\(cantidadDes)"
            celda.myStepper.value = Double(cantidadDes)
        }else{
            celda.myCantidad.text = "0"
            celda.myStepper.value = 0.0
        }
        
        //Celda - id
        celda.idProducto = producto.id
        
        //Celda - delegado
        celda.delegate = self
        
        return celda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listadoProductos.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Celda - Borrar
        let borrarCelda = UITableViewRowAction(style: .destructive, title: "Borrar") { (action, indexPath) in
            //Dejar las cantidades a 0 y borrarlo del listado
            let productoID = self.listadoProductos[indexPath.row].id
            self.listadoProductos.remove(at: indexPath.row)
            self.cantidades["\(productoID)"] = 0
            
            //Recargar la tabla
            tableView.reloadData()
            
        }
        
        borrarCelda.backgroundColor = CONSTANTES.COLOR.ROJO_GENERAL
        
        return [borrarCelda]
        
        
    }
    
}

//MARK: - Escaner QR
extension DMDListaRecibirPedido : DMDEscanerQRDelegate {
    
    ///Se permiten escanear varios productos
    func soloUno() -> Bool {
        return false
    }
    
    ///Funcion ejecutada tras recuperar todos los productos
    func getCodigosEscaneados(_ escanerQR: DMDEscanerQR, codigos : [String]){
        for codigo in codigos {
            ProductoService.shared.findByCodigoDeBarras(codigo, callback: { (producto) in
                if let obj = producto {
                    if obj.id != nil {
                        self.addProducto(obj, cantidad: 1)
                        self.myTable.reloadData()
                    }
                }
            })
        }
    }
}

//MARK: - Extension aumentar desde la lista
extension DMDListaRecibirPedido : DMDListaRecibirPedidoCeldaDelegate {
    
    ///Función ejecutada al pulsar sobre el stepper de cantidades
    func setCantidad(_ id: Int, cantidad: Int){
        cantidades["\(id)"] = cantidad
    }
}
