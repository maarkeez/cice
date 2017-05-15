//
//  Constantes.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

let CONSTANTES = Constantes()

struct Constantes {
    let TALLA = Talla()
    let COLOR = Colores()
}

struct Talla{
    let XS = "XS"
    let S = "S"
    let M = "M"
    let L = "L"
    let XL = "XL"
    let XXL = "XXL"
    let LISTADO = ["XS","S","M","L","XL","XXL"]
}

struct Colores{
    let GRIS_TAB_NAV_BAR = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    let ROJO_GENERAL = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
    let VERDE = #colorLiteral(red: 0.2980392157, green: 0.8509803922, blue: 0.3921568627, alpha: 1)
    let GRIS = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
}
