//
//  Literales.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 29/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

let CONSTANTES = Constantes()


struct Constantes {
    let CONFIGURACION_WS = ConfiguracionWS()
    let LITERALES = Literal()
    let TALLA = Talla()
}


struct Literal {
    let SIN_ASIGNAR = "Sin Asignar"
    let DESCRIPCION_NO_DISPONIBLE = "Descripción no disponible."
}

struct Talla {
    let XS = "XS"
    let S = "S"
    let M = "M"
    let L = "L"
    let XL = "XL"
    let XXL = "XXL"
    let todas = ["XS","S","M","L","XL","XXL"]
}
struct ConfiguracionWS{
    let HOST = "90.74.71.52"
    let PORT = "8081"
    let PROTOCOL = "http"
    
    var URL_CONEXION = "http://localhost:8080"
    
    init(){
        URL_CONEXION = PROTOCOL + "://" + HOST + ":" + PORT

    }
}
