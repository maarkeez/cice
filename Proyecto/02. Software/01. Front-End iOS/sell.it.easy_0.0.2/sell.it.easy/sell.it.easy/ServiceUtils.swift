//
//  ServiceUtils.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import ObjectMapper
import SwiftyJSON
import PromiseKit
import Alamofire

class ServiceUtils  {
    
    //Singleton
    static let shared = ServiceUtils()
    
    func post(_ url: String, parametros : Mappable, completion:@escaping (JSON) -> Void){
        let param = parametros.toJSON()
        Alamofire.request(url, method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON().then { (dataJSON) -> JSON in
            completion(JSON(dataJSON))
            return JSON.null
        }
    }
    
    func get(_ url: String, completion:@escaping (JSON) -> Void){
        
        Alamofire.request(url).responseJSON().then { (dataJSON) -> JSON in
            completion(JSON(dataJSON))
            return JSON.null
        }
    }
}
