//
//  DMDListaRecibirPedido.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDListaRecibirPedido: UIViewController {
//
//    //MARK: - Variables locales
//    var listadoProductos = [Producto]()
//    var cantidades = [String:Int]()
//    var isToolbarHidden : Bool?
//    
//    
//    
//    //MARK: - IBOutlets
//    
//    @IBOutlet weak var myTable: UITableView!
//    
//    //MARK: - IBActions
//    @IBAction func escanearACTION(_ sender: Any) {
//        let escanerVC =  storyboard?.instantiateViewController(withIdentifier: "EscanerQR") as! DMDEscanerQR
//        escanerVC.delegate = self
//        navigationController?.pushViewController(escanerVC, animated: true)
//        
//    }
//    
//    
//    ///Guardar la lista de productos como inventario a fecha actual
//    @IBAction func confirmarACTION(_ sender: Any) {
//        //TODO:Reimplementar
////        let listaProductos = ListaProductosRepository.shared.new()
////        listaProductos.tipo = ListaProductosRepository.shared.TIPO_RECEPCION_PEDIDO
////        listaProductos.listaproductos2producto = NSSet(array: listadoProductos)
////        
//        
//        
//    }
//    
//    @IBAction func paraMasTardeACTION(_ sender: Any) {
//        
//        
//    }
//    
//    @IBAction func cancelarACTION(_ sender: Any) {
//    
//    
//    }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //Guardamos el estado actual de la barra de navegación
//        isToolbarHidden = (navigationController?.isToolbarHidden)!
//        //Mostramos la barra inferior para poder acceder a los botones de las acciones
//        navigationController?.isToolbarHidden = false
//        
//        //Delegadosd
//        myTable.dataSource = self
//        myTable.delegate = self
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        //Se deja el estado de la barra inferior como estuviera antes de mostrar la vista
//        navigationController?.isToolbarHidden = isToolbarHidden!
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    
//    func addProducto(_ producto: Producto, cantidad: Int){
//        var existe = false
//        
//        for productoLista in listadoProductos {
//            if productoLista.id == producto.id {
//                existe = true
//                if cantidades["\(productoLista.id)"] != nil {
//                    cantidades["\(productoLista.id)"] = cantidades["\(productoLista.id)"]! + cantidad
//                }else{
//                    cantidades["\(productoLista.id)"] = cantidad
//                }
//            }
//        }
//        
//        if(!existe){
//            listadoProductos.append(producto)
//            cantidades["\(producto.id)"] = cantidad
//        }
//    }
//}
//
////MARK: - Extensión para mostrar el listado de productos
//extension DMDListaRecibirPedido: UITableViewDelegate, UITableViewDataSource{
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let celda = tableView.dequeueReusableCell(withIdentifier: "DMDListaRecibirPedidoCelda") as! DMDListaRecibirPedidoCelda
//        
//        let producto = listadoProductos[indexPath.row]
//        
//        if let imagenData = producto.imagen {
//            celda.myImagen.image =  UIImage(data: imagenData as Data)
//        }
//        
//        if let nombre = producto.nombre {
//            celda.myNombre.text = nombre
//        }
//        
//        let cantidad = cantidades["\(producto.id)"]
//        
//        if let cantidadDes = cantidad {
//            celda.myCantidad.text = "\(cantidadDes)"
//            celda.myStepper.value = Double(cantidadDes)
//        }else{
//            celda.myCantidad.text = "0"
//            celda.myStepper.value = 0.0
//        }
//        celda.idProducto = producto.id
//        celda.delegate = self
//        
//        return celda
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listadoProductos.count
//    }
//    
//   
//    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        
//        let borrarCelda = UITableViewRowAction(style: .destructive, title: "Borrar") { (action, indexPath) in
//            let productoID = self.listadoProductos[indexPath.row].id
//            self.listadoProductos.remove(at: indexPath.row)
//            self.cantidades["\(productoID)"] = 0
//            tableView.reloadData()
//            
//        }
//        borrarCelda.backgroundColor = CONSTANTES.COLOR.ROJO_GENERAL
//        
//        return [borrarCelda]
//        
//        
//    }
//    
//}
//
////MARK: - Escaner QR
//extension DMDListaRecibirPedido : DMDEscanerQRDelegate {
//    
//    func soloUno() -> Bool {
//        
//        return false
//    }
//    
//    
//    func getCodigosEscaneados(_ escanerQR: DMDEscanerQR, codigos : [String]){
//        
//        for codigo in codigos {
//            let producto = ProductoRepository.shared.findByCodigoBarras(codigo)
//            if producto != nil {
//                addProducto(producto!, cantidad: 1)
//            }
//        }
//        myTable.reloadData()
//        
//    }
//    
//    
//}
//
////MARK: - Extension aumentar desde la lista
//extension DMDListaRecibirPedido : DMDListaRecibirPedidoCeldaDelegate {
//    func setCantidad(_ id: Int32, cantidad: Int){
//        cantidades["\(id)"] = cantidad
//    }
}
