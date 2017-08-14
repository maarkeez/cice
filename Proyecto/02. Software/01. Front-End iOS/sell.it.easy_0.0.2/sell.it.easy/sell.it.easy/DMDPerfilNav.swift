//
//  DMDPerfilNav.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDPerfilNav: UINavigationController {

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

extension DMDPerfilNav :  DMDTablaDinamicaCGDelegate {
    
    func setData(_ data: DMDTablaDataCG){
        
    }
    
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        let usuario = Session.shared.usuario
        
        //Celda de perfil
        let blue_background = #imageLiteral(resourceName: "blue-background")
        let perfil = #imageLiteral(resourceName: "no-profile")
        data.listaItems.append(DMDCeldaPerfil(imagen: perfil, nombre: (usuario?.nombre!)!, fondo: blue_background))
        
        //Apellidos
        data.listaItems.append(DMDCeldaTexto(nombre: "Apellidos", texto: (usuario?.apellidos!)!))
        
        //Correo
        data.listaItems.append(DMDCeldaTexto(nombre: "Correo electrónico", texto: (usuario?.correo!)!))
        
        //Contraseña
        data.listaItems.append(DMDCeldaTexto(nombre: "Contraseña", texto: (usuario?.password!)!))

        
        return data
    }
}
