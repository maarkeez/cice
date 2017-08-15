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
    let COLOR_VIOLETA = ColoresVioletas()
    let COLOR_AZUL = ColoresAzules()
    let URL_BASE = UrlBase()
    let PRODUCTO_TIPOS = ["Textil","Alimentación","Transporte"]
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
    let AZUL_OSCURO = #colorLiteral(red: 0, green: 0.1960784314, blue: 1, alpha: 1)
    let AZUL_CLARO = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
}

struct ColoresVioletas {
    let TAB_NAV_BAR = #colorLiteral(red: 0.2352941176, green: 0.1254901961, blue: 0.2549019608, alpha: 1)
    let TEXTO = #colorLiteral(red: 0.5450980392, green: 0.2980392157, blue: 0.4784313725, alpha: 1)
    let BRILLO = #colorLiteral(red: 0.7058823529, green: 0.3921568627, blue: 0.7725490196, alpha: 1)
    let OSCURO = #colorLiteral(red: 0.2705882353, green: 0.1882352941, blue: 0.4352941176, alpha: 1)
    let SOMBRAS = #colorLiteral(red: 0.1137254902, green: 0.07058823529, blue: 0.168627451, alpha: 1)
}

struct ColoresAzules {
    let TAB_NAV_BAR = #colorLiteral(red: 0.06666666667, green: 0.3333333333, blue: 0.6666666667, alpha: 1)
    let TEXTO = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    let BRILLO = #colorLiteral(red: 0.4156862745, green: 0.5647058824, blue: 0.662745098, alpha: 1)
    let OSCURO = #colorLiteral(red: 0.8431372549, green: 0.862745098, blue: 0.8784313725, alpha: 1)
    //let SOMBRAS = #colorLiteral(red: 0, green: 0.1803921569, blue: 0.262745098, alpha: 1)
    let SOMBRAS = #colorLiteral(red: 0.01960784314, green: 0.1725490196, blue: 0.4470588235, alpha: 1)
}

struct UrlBase{
    let URL_BASE = "http://192.168.1.105"
    let PUERTO = ":8081/"
}






