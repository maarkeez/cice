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
        
       
        
        //Asignar como delegado
        viewController?.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([viewController!], animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProductoService.shared.todos { (objetos) in
            self.listado = objetos
            self.showData()
        }
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
    
    ///Mostrar el detalle para el producto seleccionado
    func didSelectRow(_ row: Int){
        let detalleNav = DMDProductoNav()
        detalleNav.producto = listado[row]
        present(detalleNav, animated: true, completion: nil)
    }
    
    ///Mostrar ventana de alta de producto
    func setData(_ data: DMDTablaDataCG){
        let detalleNav = DMDProductoNav()
        present(detalleNav, animated: true, completion: nil)
    }
    
    
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        
        for objeto in listado {
            
            let precioVentaPublico = objeto.propiedades?.precioVentaPublico ?? 0.0
            
            let celda = DMDCeldaLabel(nombre: objeto.nombre , texto: "\(precioVentaPublico)")

            celda.seleccionable = false
            data.listaItems.append(celda)
        }
        
        
        //Permitir guardado
        data.guardar = true
        data.showSearchBar = true
        
        return data
    }
}
