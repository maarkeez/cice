//
//  OrganizacionService.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import ObjectMapper
import SwiftyJSON
import Alamofire

class OrganizacionService  {
    
    static let shared = OrganizacionService()
    
    let URL_ORGANIZACION = CONSTANTES.URL_BASE.URL_BASE + CONSTANTES.URL_BASE.PUERTO + "organizacion/"
    
    func alta(_ organizacion : Organizacion, callback:@escaping (Organizacion?) -> Void){
        let URL_ALTA = URL_ORGANIZACION + "alta"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: organizacion) { (organizacionJSON) in
            let org = Organizacion(JSONString: organizacionJSON.rawString()!)
            callback(org)
        }
    }    
}
