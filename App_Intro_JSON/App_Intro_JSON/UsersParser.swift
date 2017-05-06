//
//  UsersParser.swift
//  App_Intro_JSON
//
//  Created by cice on 3/3/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import Foundation
import SwiftyJSON

class UsersParser{
    ///Permite parsear la información proporcionada como NSData para devolver un listado de Users
    /// - Parameter dataFromNetwork: Data con el contenido a convertir en un listado de objetos Users
    /// - Returns: Listado de Posts contenido en dataFromNetwork
    func getUsersParser(dataFromNetwork : NSData) -> [User]{
        var users : [User] = []
        let legibleJSON = JSON(data: dataFromNetwork as Data)
        //let legibleJSON = JSON(data: dataFromNetwork as Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        print(legibleJSON)
        for i in 0..<legibleJSON.count{
            let jsonObjet = legibleJSON[i]
            
            
            
            let geo = Geo(lat: toDouble(jsonObjet["address"]["geo"]["lat"].string), lng: toDouble(jsonObjet["address"]["geo"]["lng"].string))
            let address = Address(street: jsonObjet["address"]["street"].string, suite: jsonObjet["address"]["suite"].string, city: jsonObjet["address"]["city"].string, zipcode: jsonObjet["address"]["zipcode"].string, geo: geo)
            let company = Company(name: jsonObjet["company"]["name"].string, catchPhrase: jsonObjet["company"]["catchPhrase"].string, bs: jsonObjet["company"]["bs"].string)
            
            let user = User(id: jsonObjet["id"].int, name: jsonObjet["name"].string, email: jsonObjet["email"].string, address: address, phone: jsonObjet["phone"].string, website: jsonObjet["website"].string, company: company)
            users.append(user)
        }
        return users
    }
    
    
    func toDouble(_ cadena : String?) -> Double{
        if(cadena != nil){
            return Double(cadena!)!
        }
        return 0.0
    }
}
