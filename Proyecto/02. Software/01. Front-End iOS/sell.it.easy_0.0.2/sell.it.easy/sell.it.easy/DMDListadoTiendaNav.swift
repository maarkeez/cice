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
        
        TiendaService.shared.todos { (tiendas) in
            self.listadoTiendas = tiendas
            self.showData()
        }
        
        //Asignar como delegado
        viewController?.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([viewController!], animated: true)
        
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
    
    func setData(_ data: DMDTablaDataCG){
        let tiendaNav = DMDTiendaNav()
        present(tiendaNav, animated: true, completion: nil)
    }
    
    
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        
        for tienda in listadoTiendas {
            data.listaItems.append(DMDCeldaLabel(nombre: tienda.nombre, texto: tienda.telefono!))
        }

        
        //Permitir guardado
        data.guardar = true
        data.showSearchBar = true
        
        return data
    }
}
