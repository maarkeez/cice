//
//  APIUTILS.swift
//  iSaldos
//
//  Created by cice on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation

let CONSTANTES = Constantes()

struct Constantes{
    let COLORES = Colores()
    let LLAMADAS = Llamadas()
    let CUSTOM_USER_DEFAULTS = CustomUserDefaults()
}


struct Colores {
    let GRIS_NAV_TAB = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 1)
    let BLANCO_TEXTO_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

struct Llamadas{
    let BASE_URL = "http://api.clubsinergias.es/api_comercios.php?"
    let BASE_UR_FOTO = "http://api.clubsinergias.es/uploads/promociones/"
    let BASE_URL_LOCALIDAD = "idLocalidad"
    let OFERTA = "oferta"
    let CUPON = "cupon"
    let CONCURSO = "concurso"
    let PROMOCIONES_SERVICE = "promociones"
    
    
}


struct CustomUserDefaults{
    let VISTA_GALERIA_INICIAL = "vistaGaleriaInicial"
}

