//
//  DMDHistoricoTicket.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 7/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class DMDHistoricoTicket: UINavigationController {
    
    var viewController : DMDTablaDinamicaCG?
    var listado = [VentaFisica]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar componente genérico
        viewController = storyboard?.instantiateViewController(withIdentifier: "DMDTablaDinamicaCG") as! DMDTablaDinamicaCG
        
        //Asignar como delegado
        viewController?.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([viewController!], animated: true)
        print("Creada tabla genérica")
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Entro en viewDidAppear")
        //Recuperar todos los tickets
        VentaFisicaService.shared.todos { (objetos) in
            print("Recuperados: \(objetos.count) objetos")
            self.listado = objetos
            self.showData()
        }
    }
    
    func showData(){
        print("Se van a mostrar los datos recuperados del servidor")
        viewController?.data = getData()
        viewController?.myTable.reloadData()
    }
    
    
    
}


extension DMDHistoricoTicket :  DMDTablaDinamicaCGDelegate {
    
    //Mostrar el detalle del ticket
    func didSelectRow(_ row: Int) {
        let nav = DMDVentaFisicaDetalle()
        nav.ventaFisica = listado[row]
        present(nav,animated: true, completion: nil)
    }
    
    func setData(_ data: DMDTablaDataCG){
    }
    
    
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        print("Recuperando datos del nav")
        // Por cada ticket crear una celda con la tienda y fecha
        for venta in listado {
            
            let tiendanombre = venta.pedido?.tienda?.nombre
            let fecha = venta.pedido?.fechaCierre
            
            //Añadir la celda al listado
            let celda = DMDCeldaLabel(nombre: tiendanombre!, texto: (fecha?.stringValue)!)
            celda.seleccionable = false
            data.listaItems.append(celda)
            
        }
        
        //Permitir guardado
        data.guardar = false
        data.isBackButton = true
        
        return data
    }
}
