//
//  DMDTiendas.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 4/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDTiendas: UITableViewController {
    
    //MARK: - Variables locales
    var tiendas = [Tienda]()
    //MARK: - IBActions
    ///Esta acción muetra la ventana de AñadirProducto customizada para configurar 
    ///una nueva tienda
    ///Para ello hace uso del protocolo "ProtocoloAlta" y actuará como delegado en la nueva ventana
    @IBAction func nuevaTienda(_ sender: Any) {
        //Ventana de alta producto
        let tiendaNuevaVC : DMDAnadirProducto = self.storyboard?.instantiateViewController(withIdentifier: "AnadirProducto") as! DMDAnadirProducto
        
        let datosParaTiendaNueva : DatosProtocoloAlta = DatosProtocoloAlta()
        
        datosParaTiendaNueva.etiquetas.append("Nombre")
        datosParaTiendaNueva.etiquetas.append("Telefono")
        datosParaTiendaNueva.datos.append("Sin definir")
        datosParaTiendaNueva.datos.append("Sin definir")
        
        tiendaNuevaVC.datos = datosParaTiendaNueva
        tiendaNuevaVC.delegado = self
        self.navigationController?.pushViewController(tiendaNuevaVC, animated: true)
        
    }
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        //Recuperar las tiendas:
        tiendas = REST_tiendas.findAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tiendas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdaTienda = tableView.dequeueReusableCell(withIdentifier: "CeldaTienda", for: indexPath) as! DMDCeldaTienda
        
        celdaTienda.initIBOutlets(tienda: tiendas[indexPath.row])
        return celdaTienda
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tiendaVC : DMDTiendaDetalle = self.storyboard?.instantiateViewController(withIdentifier: "TiendaDetalle") as! DMDTiendaDetalle
        
        
        
        tiendaVC.tienda = tiendas[indexPath.row]
        
        self.navigationController?.pushViewController(tiendaVC, animated: true)
    }
   
    
    

}

extension DMDTiendas : ProtocoloAlta {
    func setDatosProtocoloAlta(datos: DatosProtocoloAlta){
        let nuevaTienda : Tienda = Tienda()
        nuevaTienda.id = 9
        nuevaTienda.imagen.imagenUI = datos.imagen
        nuevaTienda.nombre = datos.datos[0] as! String
        nuevaTienda.telefono = datos.datos[1] as! String
        
        //TODO: Falta hacer un post al servidor con la nueva tienda
        tiendas.append(nuevaTienda)
        
        self.tableView.reloadData()
    }
}
