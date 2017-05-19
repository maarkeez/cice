//
//  SAEnumerationError.swift
//  iSaldos
//
//  Created by cice on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation


enum CustomError : Error {
    
    case campoVacio
    case emailInvalido
    case usuarioExistente
    case ingresoUsuarioError
    
}

extension CustomError : CustomStringConvertible {
    var description : String {
        
        switch self {
        case .campoVacio:
            return "Ingrese todos los campos"
        case .emailInvalido:
            return "Correo inválido"
        case .usuarioExistente:
            return "Ya existe ese usuario"
        case .ingresoUsuarioError:
            return "Datos incorrectos"
        }
        
        
    }
}
