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
    
    /*func login(_ usuario : Usuario, completion:@escaping (Usuario?) -> Void){
        let URL_LOGIN = URL_USUARIO + "/login"
        
        var request = URLRequest(url: URL(string: URL_USUARIO)!)
        request.httpMethod = "POST"
        let parametros  = getUsuario(usuario)
        
        Alamofire.request(URL_LOGIN, method: HTTPMethod.post, parameters: parametros, encoding: JSONEncoding.default, headers: nil).responseJSON().then{ (dataJSON) -> JSON in
            completion(self.getUsuario(JSON(dataJSON)))
            return JSON.null
        }
    }
    
    func editarantiguo(_ usuario : Usuario, completion:@escaping (Usuario?) -> Void){
        let URL_EDITAR = URL_USUARIO + "/" + "\(usuario.id!)" + "/editar"
        print("URL_EDITAR:"+URL_EDITAR)
        
        var request = URLRequest(url: URL(string: URL_USUARIO)!)
        request.httpMethod = "POST"
        let parametros  = getUsuario(usuario)
        
        Alamofire.request(URL_EDITAR, method: HTTPMethod.post, parameters: parametros, encoding: JSONEncoding.default, headers: nil).responseJSON().then{ (dataJSON) -> JSON in
            completion(self.getUsuario(JSON(dataJSON)))
            return JSON.null
        }
    }*/
    
    func login(_ usuario : Usuario, callback:@escaping (Usuario?) -> Void){
        let URL_LOGIN = URL_USUARIO + "/login"
        
        ServiceUtils.shared.post(URL_LOGIN, parametros: usuario) { (json) in
            let obj = Usuario(JSONString: json.rawString()!)
            callback(obj)
        }
    }

    
    func editar(_ usuario : Usuario, callback:@escaping (Usuario?) -> Void){
        let URL_EDITAR = URL_USUARIO + "/" + "\(usuario.id!)" + "/editar"
        
        ServiceUtils.shared.post(URL_EDITAR, parametros: usuario) { (json) in
            let obj = Usuario(JSONString: json.rawString()!)
            callback(obj)
        }
    }

    
    func alta(_ usuario : Usuario, callback:@escaping (Usuario?) -> Void){
        let URL_ALTA = URL_USUARIO + "/alta"
        
        ServiceUtils.shared.post(URL_ALTA, parametros: usuario) { (json) in
            let obj = Usuario(JSONString: json.rawString()!)
            callback(obj)
        }
    }

    
    
    /*func alta(_ usuario : Usuario, completion:@escaping (Usuario?) -> Void){
        let URL_ALTA = URL_USUARIO + "/alta"
                
        let parametros  = getUsuario(usuario)
        
        Alamofire.request(URL_ALTA, method: HTTPMethod.post, parameters: parametros, encoding: JSONEncoding.default, headers: nil).responseJSON().then{ (dataJSON) -> JSON in
            completion(self.getUsuario(JSON(dataJSON)))
            return JSON.null
        }
    }
    
    
    func getUsuario(_ json: JSON) -> Usuario{
        var imagen : UIImage? = nil
        if let imagenStr = json["imagenString"].string{
            let dataDecoded = Data(base64Encoded: imagenStr)
            if let datos = dataDecoded {
                imagen = UIImage(data: datos)!
            }
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
            imagenString = imagenData.base64EncodedString()
        }
        
        
        return [
            "id":usuario.id,
            "correo":usuario.correo,
            "nombre":usuario.nombre,
            "apellidos":usuario.apellidos,
            "password":usuario.password,
            "imagenString":imagenString
        ]
    }*/
    
}
