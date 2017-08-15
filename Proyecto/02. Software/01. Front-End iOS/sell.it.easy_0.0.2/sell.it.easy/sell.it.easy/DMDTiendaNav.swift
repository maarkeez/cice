//
//  DMDTiendaNav.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDTiendaNav: UINavigationController {

    var tienda = Tienda(id: nil, nombre: "", imagenString: nil, telefono: "")
    
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

extension DMDTiendaNav :  DMDConfirmDelegate {
    func confirmar(){}
    func cancelar(){}
    
    func getTitulo() -> String{
        return ""
    }
    func getTexto() -> String{
        return "Sus cambios se han realizado con éxito"
    }
}


extension DMDTiendaNav :  DMDTablaDinamicaCGDelegate {
    
    func setData(_ data: DMDTablaDataCG){
        
        if let celda = data.listaItems[0] as? DMDCeldaPerfil {
            tienda.nombre = celda.nombre
            
            //Comprobamos si existe imagen para el perfil
            if let imagen = celda.imagen{
                
                var imagenTexto = Utils.shared.getTexto(imagen)
                
                //Comprobamos si la imagen ha cambiado
                if imagenTexto != tienda.imagenString {
                    //Comprimir la imagen
                    let imagenComprimida = Utils.shared.comprimirImagen(imagen)
                    
                    //Convertir a texto
                    imagenTexto = Utils.shared.getTexto(imagenComprimida)
                    
                    //Reasignar al usuario
                    tienda.imagenString = imagenTexto
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
        
        //Celda de perfil
        let blue_background = #imageLiteral(resourceName: "blue-background")
        var imagen = #imageLiteral(resourceName: "sell")
        
        if let imagenString = tienda.imagenString {
            imagen = Utils.shared.getImagen(imagenString)!
        }
        data.listaItems.append(DMDCeldaPerfil(imagen: imagen, nombre: tienda.nombre!, fondo: blue_background))
        
        //Apellidos
        data.listaItems.append(DMDCeldaLabel(nombre: "Telefono", texto: tienda.telefono!))
        
        //Permitir guardado
        data.guardar = true
        data.isBackButton = true
        
        return data
    }
}
