//
//  DummyTablaDataCG.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/7/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class DummyTablaDataCG {
    ///Singleton
    static let shared = DummyTablaDataCG()
    
    func getDummyData() -> DMDTablaDataCG{
        
        let data = DMDTablaDataCG()
        
        //Celda de perfil
        let blue_background = #imageLiteral(resourceName: "blue-background")
        let perfil = #imageLiteral(resourceName: "no-profile")
        data.listaItems.append(DMDCeldaPerfil(imagen: perfil, nombre: "David Márquez Delgado", fondo: blue_background))
        
        //Celdas de fecha
        data.listaItems.append(DMDCeldaFecha(texto: "Fecha alta", fecha: Date()))
        
        //Celdas de fecha
        data.listaItems.append(DMDCeldaTextoLargo(nombre: "Descripción", texto: "Lorem ipsum"))
        
        
        //Celdas barcode
        data.listaItems.append(DMDCeldaCodigoBarras(codigoBarras: "999999"))
        
        //Celda selector
        data.listaItems.append(DMDCeldaSelector(titulo: "Talla", indiceSeleccionado: 1, opciones: ["S","M","L","XL","XXL"]))
        
        //Celdas de texto
        for i in  1...10 {
            data.listaItems.append(DMDCeldaTexto(nombre: "Texto de prueba \(i)", texto: "Valor de prueba"))
        }
        
        return data
    }

}
