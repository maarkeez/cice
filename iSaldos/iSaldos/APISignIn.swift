//
//  SASignIn.swift
//  iSaldos
//
//  Created by cice on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import Parse

class APISignIn : NSObject {
    
    
    var username : String?
    var password : String?
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    ///Permite registrar el usuario o devuelve una excepción
    func signUser() throws {
        
        guard camposVacios() else {
            throw CustomError.campoVacio
        }
        
        guard validarDatosUsuario() else {
            throw CustomError.ingresoUsuarioError
        }
    }
    
    ///Comprueba que todos los campos tengan datos
    func camposVacios() -> Bool {
        return  !(username?.isEmpty)! && !(password?.isEmpty)!
    }
    
    ///Comprueba que puedas hacer login contra Parse
    func validarDatosUsuario() -> Bool{
        
        do{
            //Intentar registrar
            try PFUser.logIn(withUsername: username!, password: password!)
            
        }catch let error {
            print("validarDatosUsuario.Error: \(error.localizedDescription)")
        }
        
        //Si tenemos el usuario
        return  PFUser.current() != nil
    }
}
