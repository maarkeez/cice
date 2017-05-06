//
//  GMParserPhotosData.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit
// import Alamofire
import CoreData // DMD: Para mi parser

class GMParserPhotosData : NSObject {
    //Dato que promteo devolver
    var jsonDataPhotos : JSON?
    
    ///Protemo devolver un JSON. Usando alamofire
    /// - returns: Promesa de objeto JSON tras ejecutarse la llamada de manera asíncrona
    func getDatosPhotos() -> Promise<JSON>{
        //Genero la URL de la que voy a recuperar la foto
        let customRequest = URLRequest(url: URL(string: CONSTANTES.BASE_URL.PHOTOS)!)
        
        //Obtengo la respuesta a partir de la URLRequest
        //Tras obtener la respuesta, Recupero el JSON y lo devuelvo desempaquetado
        return Alamofire.request(customRequest).responseJSON().then{ (data) -> JSON in
            self.jsonDataPhotos = JSON(data)
            return self.jsonDataPhotos!
        }
    }
    
    ///Parsea generando un array de fotos a partir del JSON guardado en la variable local
    /// - returns: [Placeholder] array de fotos alimentado a partir de llamada asíncrona de getDatosPhotos()
    func getParserPhotos() -> [Placeholder]{
        var arrayPhotos = [Placeholder]()
        
        for item in jsonDataPhotos!{
            let photo = Placeholder(albumId: getInt(item.1, key: "albumId"), id: getInt(item.1, key: "id"), title: getString(item.1, key: "title"), url: getString(item.1, key: "url"), thumbnailUrl: getString(item.1, key: "thumbnailUrl"))
            arrayPhotos.append(photo)
            
        }
        return arrayPhotos
    }
    
    ///Parsea generando un array de fotos a partir del JSON guardado en la variable local.
    ///
    /// `Generado a partir de Parseador customizado`
    /// - returns: [Placeholder] array de fotos alimentado a partir de llamada asíncrona de getDatosPhotos()
    func getParserPhotosDMD() -> [Placeholder]{
        var arrayPhotos = [Placeholder]()
        
        for item in jsonDataPhotos!{
            var photo = Placeholder()
            let mirror = Mirror(reflecting: photo)
            photo = Parseador.shared.parse(with: mirror, from: item.1, to: photo) as! Placeholder
           // Parseador.shared.listPropertiesWithValues(reflect: Mirror(reflecting: photo))
            arrayPhotos.append(photo)
        }
        return arrayPhotos
    }
}
