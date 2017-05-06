//
//  Utils.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation

let CONSTANTES = Constantes()

struct Constantes {
    let COLORES = Colores()
    let BASE_URL = BaseURL()
}

struct Colores {
    let AZUL_BARRA_NAV = #colorLiteral(red: 0.1764705882, green: 0.4980392157, blue: 0.7568627451, alpha: 1)
    let BLANCO_TEXTO_BARRA_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

struct BaseURL {
    let PHOTOS = "https://jsonplaceholder.typicode.com/photos"
    let OMDB = "https://www.omdbapi.com/?s="
}
