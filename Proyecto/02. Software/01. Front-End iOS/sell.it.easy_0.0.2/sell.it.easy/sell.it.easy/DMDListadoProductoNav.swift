//
//  DMDListadoProductoNav.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDListadoProductoNav: UINavigationController {

    
    var listado = [Producto]()
    var viewController : DMDTablaDinamicaCG?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar componente genérico
        viewController = storyboard?.instantiateViewController(withIdentifier: "DMDTablaDinamicaCG") as! DMDTablaDinamicaCG
        
        ProductoService.shared.todos { (objetos) in
            self.listado = objetos
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

extension DMDListadoProductoNav :  DMDConfirmDelegate {
    func confirmar(){}
    func cancelar(){}
    
    func getTitulo() -> String{
        return ""
    }
    func getTexto() -> String{
        return "Sus cambios se han realizado con éxito"
    }
}


extension DMDListadoProductoNav :  DMDTablaDinamicaCGDelegate {
    
    func setData(_ data: DMDTablaDataCG){
        let tiendaNav = DMDProductoNav()
        present(tiendaNav, animated: true, completion: nil)
    }
    
    
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        
        for objeto in listado {
            let celda = DMDCeldaLabel(nombre: objeto.nombre , texto: "\(objeto.propiedades?.precioVentaPublico)")
            celda.seleccionable = false
            data.listaItems.append(celda)
        }
        
        
        //Permitir guardado
        data.guardar = true
        data.showSearchBar = true
        
        return data
    }
}
