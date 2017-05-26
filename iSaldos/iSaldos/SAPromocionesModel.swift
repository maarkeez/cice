//
//  SAPromocionesModel.swift
//  iSaldos
//
//  Created by David Márquez Delgado on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAPromocionesModel: NSObject {

    //MARK: - Variables locales
    let URL_PROMOCIONES = "http://app.clubsinergias.es/api_comercios.php?idlocalidad=11&tipo=oferta&p=promociones"
 
    
    var id : String?
    var tipoPromocion : String?
    var nombre : String?
    var importe : String?
    var imagen : String?
    var fechaFin : String?
    var masInformacion: String?
    var asociado : SAAsociadoModel?
    
    
    init( id : String?, tipoPromocion : String?, nombre : String?, importe : String?, imagen : String?, fechaFin : String?, masInformacion: String?, asociado : SAAsociadoModel? ){
        self.id = id
        self.tipoPromocion = tipoPromocion
        self.nombre = nombre
        self.importe = importe
        self.imagen = imagen
        self.fechaFin = fechaFin
        self.masInformacio = masInformacio
        self.asociado = asociado
        
    }
    
}
