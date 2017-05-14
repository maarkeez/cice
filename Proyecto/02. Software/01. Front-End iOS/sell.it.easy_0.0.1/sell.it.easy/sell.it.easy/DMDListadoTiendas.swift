//
//  DMDListadoTiendas.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDListadoTiendas: UIViewController {

    //MARK: - Variables locales
    var listadoTiendas = [Tienda]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mostrarMenu(myMenuBTN)
        
        listadoTiendas = TiendaRepository.shared.findAllOrderByNombre()
        
        
        myTable.register(UINib(nibName: "DMDListadoTiendaCelda", bundle: nil), forCellReuseIdentifier: "DMDListadoTiendaCelda")
        
        myTable.dataSource = self
        myTable.delegate = self
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalleTiendaSegue" {
            let detalleVC = segue.destination as! DMDDetalleTienda
            detalleVC.delegate = self
            
        }
    }
}


//MARK: - Extensión para mostrar el listado de productos
extension DMDListadoTiendas: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "DMDListadoTiendaCelda") as! DMDListadoTiendaCelda
        
        let tienda = listadoTiendas[indexPath.row]
        if let imagenData = tienda.imagen {
            celda.myImagen.image =  UIImage(data: imagenData as Data)
        }
        
        if let nombre = tienda.nombre {
            celda.myNombre.text = nombre
            
        }
        
        
        
        celda.myTelefono.text = tienda.telefono ?? ""
        
        return celda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listadoTiendas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}


//MARK: - Delegado para el detalle
extension DMDListadoTiendas : DMDDetalleTiendaDelegate{
    func guardar() {
        listadoTiendas = TiendaRepository.shared.findAllOrderByNombre()
        myTable.reloadData()
    }
}
