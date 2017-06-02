//
//  SAParserNasa.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class SAParserNasa: NSObject {

    //MARK: - Variables locales
    var jsonDataNasa : JSON?
    var URLNasa = "http://nasa.teamcl.com/api/noticias.php"
    
    func getDatosNasa() -> Promise<JSON>{
        
        let peticion = URLRequest(url: URL(string: URLNasa)!)
        
        return Alamofire.request(peticion).responseJSON().then{ (dataJSON) -> JSON in
            self.jsonDataNasa = JSON(dataJSON)
            return self.jsonDataNasa!
        }
    }
    
    ///Recupera un listado de datos de la nasa a partir del valor en la variable "jsonDataPromociones"
    func getParserPromociones() -> [SANasaModel]{
        
        //Variable a devolver
        var listadoNasa = [SANasaModel]()
        
        //Recorrer el array de promociones del JSON
        for nasaJSON in (jsonDataNasa?["news"])!{
            
       
            let nasa = SANasaModel(Id: dimeString(nasaJSON.1, nombre: "Id"),
                                   fecha: dimeString(nasaJSON.1, nombre: "fecha"),
                                   date: dimeString(nasaJSON.1, nombre: "date"),
                                   explanation: dimeString(nasaJSON.1, nombre: "explanation"),
                                   hdurl: dimeString(nasaJSON.1, nombre: "hdurl"),
                                   media_type: dimeString(nasaJSON.1, nombre: "media_type"),
                                   service_version: dimeString(nasaJSON.1, nombre: "service_version"),
                                   title: dimeString(nasaJSON.1, nombre: "title"),
                                   url: dimeString(nasaJSON.1, nombre: "url"))
            //Añadir al listado
            listadoNasa.append(nasa)
        }
        //Devolver el listado recuperado
        return listadoNasa
    }
    
    
    
    
}
