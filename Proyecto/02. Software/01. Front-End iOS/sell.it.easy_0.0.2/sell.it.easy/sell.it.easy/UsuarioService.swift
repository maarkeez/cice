//
//  UsuarioService.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 13/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class UsuarioService  {
    
    //Singleton
    static let shared = UsuarioService()
    
    let URL_USUARIO = CONSTANTES.URL_BASE.URL_BASE + CONSTANTES.URL_BASE.PUERTO + "usuario"
    
    func login(_ usuario : Usuario, completion:@escaping (Usuario?) -> Void){
        let URL_LOGIN = URL_USUARIO + "/login"
        
        var request = URLRequest(url: URL(string: URL_USUARIO)!)
        request.httpMethod = "POST"
        let parametros  = getUsuario(usuario)
        
        Alamofire.request(URL_LOGIN, method: HTTPMethod.post, parameters: parametros, encoding: JSONEncoding.default, headers: nil).responseJSON().then{ (dataJSON) -> JSON in
            completion(self.getUsuario(JSON(dataJSON)))
            return JSON.null
        }
    }
    
    func editar(_ usuario : Usuario, completion:@escaping (Usuario?) -> Void){
        let URL_EDITAR = URL_USUARIO + "/" + "\(usuario.id!)" + "/editar"
        print("URL_EDITAR:"+URL_EDITAR)
        
        var request = URLRequest(url: URL(string: URL_USUARIO)!)
        request.httpMethod = "POST"
        let parametros  = getUsuario(usuario)
        
        Alamofire.request(URL_EDITAR, method: HTTPMethod.post, parameters: parametros, encoding: JSONEncoding.default, headers: nil).responseJSON().then{ (dataJSON) -> JSON in
            completion(self.getUsuario(JSON(dataJSON)))
            return JSON.null
        }
    }
    
    
    func getUsuario(_ json: JSON) -> Usuario{
        var imagen : UIImage? = nil
        if let imagenStr = json["imagenString"].string{
            let dataDecoded = Data(base64Encoded: imagenStr, options: NSData.Base64DecodingOptions(rawValue: 0))!
            imagen = UIImage(data: dataDecoded)!
        }
        let usuario = Usuario(id: json["id"].int,
                              correo: json["correo"].string,
                              nombre: json["nombre"].string,
                              apellidos: json["apellidos"].string,
                              password: json["password"].string,
                              imagen: imagen)
        return usuario
    }
    
    func getUsuario(_ usuario: Usuario) -> [String:Any] {
        var imagenString = ""
        if let imagen = usuario.imagen {
            let imagenData = UIImagePNGRepresentation(imagen)!
            imagenString = imagenData.base64EncodedString(options: .lineLength64Characters)
        }
        
        
        return [
            "id":usuario.id,
            "correo":usuario.correo,
            "nombre":usuario.nombre,
            "apellidos":usuario.apellidos,
            "password":usuario.password,
            "imagenString":imagenString
        ]
    }
    
}
