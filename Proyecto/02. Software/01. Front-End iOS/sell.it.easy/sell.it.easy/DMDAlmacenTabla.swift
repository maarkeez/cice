//
//  DMDAlmacenTabla.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 21/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDAlmacenTabla: UITableViewController {
    
    //MARK : - Variables locales
    var listadoProductos : [Producto] = []
    var tienda : Tienda!
    
    //MARK : - Life VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperamos el listado de productos
        listadoProductos = REST_productos.findAllByTienda(tienda: tienda)
        
        //Registramos la celda para ser reutilizada en esta tabla.
        tableView.register(UINib(nibName: "DMDAlmacenCelda", bundle: nil), forCellReuseIdentifier: "AlmacenCelda")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        //Sólo es necesaria una sección
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Existirán tantas celdas como productos cargados
        return listadoProductos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Recuperamos la celda registrada anteriormente
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlmacenCelda", for: indexPath) as! DMDAlmacenCelda
        //Esconder separador
        cell.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, cell.bounds.size.width)
        
        //Recuperamos el producto del array, y lo mostramos en la celda
        cell.setIBOutlets(producto: listadoProductos[indexPath.row] )
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Establecemos el tamaño predefinido por celda
        return 207
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalleProducto : DMDDetalleProductoVC = self.storyboard?.instantiateViewController(withIdentifier: "DetalleProducto") as! DMDDetalleProductoVC
        
        detalleProducto.producto = listadoProductos[indexPath.row]        
        
        self.navigationController?.pushViewController(detalleProducto, animated: true)
    }

}
