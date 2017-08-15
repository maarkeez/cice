//
//  DNDProductoNav.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDProductoNav: UINavigationController {
    
    
    var producto = Producto(id: nil , nombre: "", descripcion: "", tipoProducto: nil, propiedades: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar componente genérico
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "DMDTablaDinamicaCG") as! DMDTablaDinamicaCG
        
        //Asignar como delegado
        viewController.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([viewController], animated: true)
        
    }
    
}

extension DMDProductoNav :  DMDConfirmDelegate {
    func confirmar(){}
    func cancelar(){}
    
    func getTitulo() -> String{
        return ""
    }
    func getTexto() -> String{
        return "Sus cambios se han realizado con éxito"
    }
}


extension DMDProductoNav :  DMDTablaDinamicaCGDelegate {
    
    func setData(_ data: DMDTablaDataCG){
        
        if producto.propiedades != nil {
            producto.propiedades = PropiedadProducto()
        }
        
        if let celda = data.listaItems[0] as? DMDCeldaPerfil {
            producto.nombre = celda.nombre
            
            //Comprobamos si existe imagen para el perfil
            if let imagen = celda.imagen{
                
                var imagenTexto = Utils.shared.getTexto(imagen)
                
                //Comprobamos si la imagen ha cambiado
                if imagenTexto != producto.propiedades?.imagenString {
                    //Comprimir la imagen
                    let imagenComprimida = Utils.shared.comprimirImagen(imagen)
                    
                    //Convertir a texto
                    imagenTexto = Utils.shared.getTexto(imagenComprimida)
                    
                    //Reasignar al usuario
                    producto.propiedades.imagenString = imagenTexto
                }
            }
            
        }
        
        if let celda = data.listaItems[1] as? DMDCeldaLabel {
            tienda.telefono = celda.texto
        }
        
        if tienda.id != nil{
            TiendaService.shared.editar(tienda) { (tienda) in
                if tienda != nil {
                    showDMDConfirm(self)
                }
            }
        }else{
            TiendaService.shared.alta(tienda) { (tienda) in
                if tienda != nil {
                    showDMDConfirm(self)
                }
            }
        }
    }
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        
        // 0 - Celda de perfil
        let blue_background = #imageLiteral(resourceName: "blue-background")
        var imagen = #imageLiteral(resourceName: "uniform")
        
        if let imagenString = producto.propiedades?.imagenString {
            imagen = Utils.shared.getImagen(imagenString)!
        }
        data.listaItems.append(DMDCeldaPerfil(imagen: imagen, nombre: producto.nombre!, fondo: blue_background))
        
        // 1 -
        data.listaItems.append(DMDCeldaTexto(nombre: "Descripción", texto: producto.descripcion))
        
        // 2 -
        data.listaItems.append(DMDCeldaSelector(titulo: "Tipo producto", indiceSeleccionado: 1, opciones: ["Textil","Alimentación","Transporte"]))
        
        // 3 - barcode
        data.listaItems.append(DMDCeldaCodigoBarras(codigoBarras: ""))
        
        // 4 - 
        data.listaItems.append(DMDCeldaSelector(titulo: "Talla", indiceSeleccionado: 1, opciones: ["S","M","L","XL","XXL"]))
        
        //Permitir guardado
        data.guardar = true
        data.isBackButton = true
        
        return data
    }
}

