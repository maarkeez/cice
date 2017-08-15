//
//  DMDPerfilNav.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDPerfilNav: UINavigationController {
    
    var isBackButton : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar componente genérico
        let perfilVC = storyboard?.instantiateViewController(withIdentifier: "DMDTablaDinamicaCG") as! DMDTablaDinamicaCG

        //Asignar como delegado
        perfilVC.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([perfilVC], animated: true)
        
    }

}

extension DMDPerfilNav :  DMDConfirmDelegate {
    func confirmar(){}
    func cancelar(){}
    
    func getTitulo() -> String{
        return "Perfil modificado"
    }
    func getTexto() -> String{
        return "Su perfil ha sido modificado con éxito"
    }
}


extension DMDPerfilNav :  DMDTablaDinamicaCGDelegate {
    
    func setData(_ data: DMDTablaDataCG){
        let usuario = Session.shared.usuario
        
        if let celda = data.listaItems[0] as? DMDCeldaPerfil {
            usuario?.nombre = celda.nombre
            
            //Comprobamos si existe imagen para el perfil
            if let imagen = celda.imagen{
                
                var imagenTexto = Utils.shared.getTexto(imagen)
                
                //Comprobamos si la imagen ha cambiado
                if imagenTexto != usuario?.imagenString {
                    //Comprimir la imagen
                    let imagenComprimida = Utils.shared.comprimirImagen(imagen)
                    
                    //Convertir a texto
                    imagenTexto = Utils.shared.getTexto(imagenComprimida)
                    
                    //Reasignar al usuario
                    usuario?.imagenString = imagenTexto
                }
            }
            
        }

        if let celda = data.listaItems[1] as? DMDCeldaLabel {
            usuario?.apellidos = celda.texto
        }
        
        if let celda = data.listaItems[2] as? DMDCeldaLabel {
            usuario?.correo = celda.texto
        }
        
        if let celda = data.listaItems[3] as? DMDCeldaLabel {
            usuario?.password = celda.texto
        }
        
        if usuario?.id != nil{
            UsuarioService.shared.editar(usuario!) { (usuario) in
                if usuario != nil {
                    Session.shared.usuario = usuario
                    showDMDConfirm(self)
                }
            }
        }else{
            UsuarioService.shared.alta(usuario!) { (usuario) in
                if usuario != nil {
                    Session.shared.usuario = usuario
                    showDMDConfirm(self)
                }
            }
        }
    }
    
    
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        let usuario = Session.shared.usuario
        
        //Celda de perfil
        let blue_background = #imageLiteral(resourceName: "blue-background")
        var perfil = #imageLiteral(resourceName: "no-profile")
        if let imagenString = usuario?.imagenString {
            perfil = Utils.shared.getImagen(imagenString)!
        }
        data.listaItems.append(DMDCeldaPerfil(imagen: perfil, nombre: (usuario?.nombre!)!, fondo: blue_background))
        
        //Apellidos
        data.listaItems.append(DMDCeldaLabel(nombre: "Apellidos", texto: (usuario?.apellidos!)!))
        
        //Correo
        data.listaItems.append(DMDCeldaLabel(nombre: "Correo electrónico", texto: (usuario?.correo!)!))
        
        //Contraseña
        data.listaItems.append(DMDCeldaLabel(nombre: "Contraseña", texto: (usuario?.password!)!))

        //Permitir guardado
        data.guardar = true
        data.isBackButton = self.isBackButton
        return data
    }
}
