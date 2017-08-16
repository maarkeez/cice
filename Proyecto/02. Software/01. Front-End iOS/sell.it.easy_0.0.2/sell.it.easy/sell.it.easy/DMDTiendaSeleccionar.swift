//
//  DMDTiendaSeleccionar.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 16/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

protocol DMDTiendaSeleccionarDelegate {
    func didSelectTienda(_ tienda: Tienda)
}
class DMDTiendaSeleccionar: UINavigationController {

    var listadoTiendas = [Tienda]()
    var viewController : DMDTablaDinamicaCG?
    var delegado : DMDTiendaSeleccionarDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar componente genérico
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        viewController = mainStoryBoard.instantiateViewController(withIdentifier: "DMDTablaDinamicaCG") as! DMDTablaDinamicaCG
        
        //Asignar como delegado
        viewController?.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([viewController!], animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showDMDConfirm(self)
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

extension DMDTiendaSeleccionar : DMDConfirmDelegate {
    func confirmar(){}
    func cancelar(){}
    
    func getTitulo() -> String {
        return "Atención"
    }
    
    func getTexto() -> String{
        return "Seleccione una tienda entre las disponibles."
    }
}



extension DMDTiendaSeleccionar :  DMDTablaDinamicaCGDelegate {
    
    
    ///Mostrar el detalle para el producto seleccionado
    func didSelectRow(_ row: Int){
        let tienda = listadoTiendas[row]
        delegado?.didSelectTienda(tienda)
        dismiss(animated: true, completion: nil)
    }
    
    
    func setData(_ data: DMDTablaDataCG){ }
    
    
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        
        for tienda in listadoTiendas {
            let celda = DMDCeldaLabel(nombre: tienda.nombre, texto: tienda.telefono!)
            celda.seleccionable = false
            data.listaItems.append(celda)
        }
        
        
        //Permitir guardado
        data.guardar = false
        data.showSearchBar = true
        data.isBackButton = true
        
        return data
    }
}
