//
//  DMDListaProductos.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDListaProductos: UIViewController {
    
    //MARK: - Variables locales
    var listadoProductos =  [Producto]()
    //MARK: - IBOulets
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mostrarMenu(myMenuBTN)
        
        listadoProductos = ProductoRepository.shared.findAllOrderByNombre()
        
        
        myTable.register(UINib(nibName: "listadoProductoCelda", bundle: nil), forCellReuseIdentifier: "listadoProductoCelda")
        
        myTable.dataSource = self
        myTable.delegate = self
       
        
    }

    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleProductoSegue" {
            let detalleVC = segue.destination as! DMDDetalleProducto
            detalleVC.delegate = self
            
        }
    }

}

//MARK: - Extensión para mostrar el listado de productos
extension DMDListaProductos: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "listadoProductoCelda") as! listadoProductoCelda
        
        let producto = listadoProductos[indexPath.row]
        if let imagenData = producto.imagen {
            celda.myImagen.image =  UIImage(data: imagenData as Data)
        }
        
        if let nombre = producto.nombre {
            celda.myNombre.text = nombre
            
        }
        
        
        
        celda.myPrecio.text = "\(producto.pvp)"
        
        return celda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listadoProductos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let borrarCelda = UITableViewRowAction(style: .destructive, title: "Borrar") { (action, indexPath) in
            
            let tienda = self.listadoProductos[indexPath.row]
            ProductoRepository.shared.deleteById(tienda.id)
            self.listadoProductos = ProductoRepository.shared.findAllOrderByNombre()
            tableView.reloadData()
            
        }
        borrarCelda.backgroundColor = CONSTANTES.COLOR.ROJO_GENERAL
        
        return [borrarCelda]
        
        
    }
    
}

//MARK: - Extesión para ser delegado de detalle producto
extension DMDListaProductos: DMDDetalleProductoDelegate{
    func guardar() {
        listadoProductos = ProductoRepository.shared.findAllOrderByNombre()
        myTable.reloadData()
    }
}


