//
//  SAParserPromociones.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire


class SAParserPromociones: NSObject {
    
    //MARK: - Variables locales
    
    
    ///Variable que contiene los datos de la promociones cuando se llama a la consulta "getDatosPromociones"
    var jsonDataPromociones : JSON?
    
    ///Permite recuperar los datos de las promociones a partir de un servicio web y los parámetros de entrada
    func getDatosPromociones(_ idLocalidad : String, idTipo: String, idParametro: String) -> Promise<JSON>{
        
        //Construir la url a la que vamos a realizar la consulta
        let urlConsulta = CONSTANTES.LLAMADAS.BASE_URL + CONSTANTES.LLAMADAS.BASE_URL_LOCALIDAD + idLocalidad + "&tipo=" + idTipo + "&p=" + idParametro
        
        //Crear la petición a la URL
        let peticion = URLRequest(url: URL(string:  urlConsulta)!)
        
        
        //Devolver los datos
        return Alamofire.request(peticion).responseJSON().then{ (dataJSON) -> JSON in
            self.jsonDataPromociones = JSON(dataJSON)
            return self.jsonDataPromociones!
        }
    }
    
    
    ///Recupera un listado de promociones a partir del valor en la variable "jsonDataPromociones"
    func getParserPromociones() -> [SAPromocionesModel]{
        
        //Variable a devolver
        var promociones = [SAPromocionesModel]()
        
        //Recorrer el array de promociones del JSON
        for promocionJSON in (jsonDataPromociones?["promociones"])!{
            
            //Recuperar datos para el asociado
            let asociado = SAAsociadoModel(id: dimeString(promocionJSON.1["asociado"], nombre: "id"),
                                           nombre: dimeString(promocionJSON.1["asociado"], nombre: "nombre"),
                                           descripcion: dimeString(promocionJSON.1["asociado"], nombre: "descripcion"),
                                           condicionesEspeciales: dimeString(promocionJSON.1["asociado"], nombre: "condicionesEspeciales"),
                                           direccion: dimeString(promocionJSON.1["asociado"], nombre: "direccion"),
                                           idActividad: dimeString(promocionJSON.1["asociado"], nombre: "idActividad"),
                                           idLocalidad: dimeString(promocionJSON.1["asociado"], nombre: "idLocalidad"),
                                           imagen: dimeString(promocionJSON.1["asociado"], nombre: "imagen"),
                                           telefonoFijo: dimeString(promocionJSON.1["asociado"], nombre: "telefonoFijo"),
                                           telefonoMovil: dimeString(promocionJSON.1["asociado"], nombre: "telefonoMovil"),
                                           mail: dimeString(promocionJSON.1["asociado"], nombre: "mail"),
                                           web: dimeString(promocionJSON.1["asociado"], nombre: "web"))
            
            
            
            
            
            
            //Recuperar datos para la promocion
            let promocion = SAPromocionesModel(id: dimeString(promocionJSON.1, nombre: "id"),
                                               tipoPromocion: dimeString(promocionJSON.1, nombre: "tipoPromocion"),
                                               nombre: dimeString(promocionJSON.1, nombre: "nombre"),
                                               importe: dimeString(promocionJSON.1, nombre: "importe"),
                                               imagen: dimeString(promocionJSON.1, nombre: "imagen"),
                                               fechaFin: dimeString(promocionJSON.1, nombre: "fechaFin"),
                                               masInformacion: dimeString(promocionJSON.1, nombre: "masInformacion"),
                                               asociado: asociado)
            
            //Añadir al listado
            promociones.append(promocion)
        }
        
        //Devolver el listado recuperado
        return promociones
    }
    
    
    
}


























