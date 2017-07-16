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
        
        for i in  1...10 {
            data.listaItems.append(DMDCeldaTexto(nombre: "Texto de prueba \(i)", texto: "Valor de prueba"))
        }
        data.listaItems.append(DMDCeldaFecha(texto: "Fecha alta", fecha: Date()))
        
        
        return data
    }

}
