//
//  DMDListadoTiendaNav.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDListadoTiendaNav: UINavigationController {
    
    var listadoTiendas = [Tienda]()
    var viewController : DMDTablaDinamicaCG?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar componente genérico
        viewController = storyboard?.instantiateViewController(withIdentifier: "DMDTablaDinamicaCG") as! DMDTablaDinamicaCG
        
      
        
        //Asignar como delegado
        viewController?.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([viewController!], animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TiendaService.shared.todos { (tiendas) in
            self.listadoTiendas = tiendas
            self.showData()
        }
    }
    
    func showData(){
        viewController?.data = getData()
        viewController?.myTable.reloadData()
    }
    
}

extension DMDListadoTiendaNav :  DMDConfirmDelegate {
    func confirmar(){}
    func cancelar(){}
    
    func getTitulo() -> String{
        return ""
    }
    func getTexto() -> String{
        return "Sus cambios se han realizado con éxito"
    }
}


extension DMDListadoTiendaNav :  DMDTablaDinamicaCGDelegate {
    
    
    ///Mostrar el detalle para el producto seleccionado
    func didSelectRow(_ row: Int){
        let detalleNav = DMDTiendaNav()
        detalleNav.tienda = listadoTiendas[row]
        present(detalleNav, animated: true, completion: nil)
    }

    
    func setData(_ data: DMDTablaDataCG){
        let tiendaNav = DMDTiendaNav()
        present(tiendaNav, animated: true, completion: nil)
    }
    
    
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        
        for tienda in listadoTiendas {
            let celda = DMDCeldaLabel(nombre: tienda.nombre, texto: tienda.telefono!)
            celda.seleccionable = false
            data.listaItems.append(celda)
        }

        
        //Permitir guardado
        data.guardar = true
        data.showSearchBar = true
        
        return data
    }
}
