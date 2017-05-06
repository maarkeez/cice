//
//  Utils.swift
//  App_iMDb
//
//  Created by cice on 28/4/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation
import UIKit

let CONSTANTES = Constantes()

struct Constantes{
    let COLOR = Colores()
    let URL = Urls()
    let METODO = Metodos()
}

struct Colores{
    let GRIS_TAB_NAV_BAR = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    let ROJO_GENERAL = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
}

struct Urls {
    let ITUNES = "https://itunes.apple.com/"
}

struct Metodos {
    let SEARCH = "search"
    let TOP = "es/rss/topmovies/limit=99/json"

}
