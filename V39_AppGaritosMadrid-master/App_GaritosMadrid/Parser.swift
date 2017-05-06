//
//  Parser.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 6/3/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//
import Foundation
import SwiftyJSON
import CoreData

/*
 - Las instancias de las clases a utilizar en la función parse deben extender de NSObject.
 - Un ejemplo de la declaración de la clase usuario:
 
 @objc(Usuario)
 class Usuario : NSObject {
 var id : Int = 0
 var nombre : String = ""
 var apellidos : String = ""
 var correo : String = ""
 var password : String = ""
 var roles : [Rol]? = []
 var imagen : Imagen?
 
 
 override init(){
 super.init()
 }
 }
 
 Tanto la clase Imagen como la clase Rol deberán extender NSObject de la misma forma.
 
 */
class Parseador {
    static let shared = Parseador()
    
    
    /// Conversor de JSON a Class : NSObject
    /// - parameter reflect:    Mirror de instancia
    /// - parameter json:       JSON con el contenido para inicializar la instancia
    /// - parameter instancia:  Instancia de la clase a la que queremos convertir el JSON
    /// - returns: NSObject? de la misma Class que instancia
    func parse(with reflect: Mirror? = nil, from json : JSON, to instancia : NSObject) -> NSObject? {
        
        if reflect != nil{
            
            //Recuperamos la clase de la instancia
            let claseString = String(describing: type(of: instancia))
            
            // Creamos una instancia del mismo tipo
            let objeto = NSClassFromString(claseString) as! NSObject.Type
            
            // Instanciamos el NSObject a sus valores inciales
            // esta variable será que se va a devolver, con los atributos inicializados en función del JSON
            let instanciaObjeto = objeto.init()
            
            //Desencapsulamos la copia del objeto a analizar
            let mirror = reflect!
            
            //Recorremos los atributos de la clase que queremos construir
            for  (_, attr) in mirror.children.enumerated() {
                //Comprobamos que el atributo tiene un nombre, para poder darle valor
                if let property_name = attr.label as String! {
                    // Parseamos en función del tipo
                    // Ordenados por
                    if(json[property_name] == JSON.null){
                        // NULL
                        instanciaObjeto.setValue(nil, forKey: property_name)
                    } else if attr.value is String {
                        // STRING:
                        instanciaObjeto.setValue( json[property_name].string, forKey: property_name)
                    } else if attr.value is  Int  {
                        // INT:
                        instanciaObjeto.setValue(json[property_name].int, forKey: property_name)
                    } else if attr.value is  Double {
                        // DOUBLE:
                        instanciaObjeto.setValue(json[property_name].double, forKey: property_name)
                    } else if attr.value is  Bool {
                        // BOOLEAN:
                        instanciaObjeto.setValue(json[property_name].bool, forKey: property_name)
                    } else if attr.value is  Float {
                        // FLOAT:
                        instanciaObjeto.setValue(json[property_name].float, forKey: property_name)
                    } else if attr.value is [NSObject] {
                        // ARRAY:
                        
                        // Creamos el array vacío, que se asociará al atributo
                        var atributos : [NSObject?] = []
                        
                        // Para cada elemento del array en el JSON
                        for i in 0..<json[property_name].count{
                            
                            // Creamos una copia del objeto, para recuperar el tipo
                            let mirrorAtribute = Mirror(reflecting: attr.value)
                            
                            // A partir del método privado y la copia, recuperamos el tipo del Elemento para el array.
                            let tipoAtributo = getClassName(mirrorSubjectType: String(describing: mirrorAtribute.subjectType))
                            
                            // Creamos un objeto a partir del nombre de la clase
                            let attrObj = NSClassFromString(tipoAtributo) as! NSObject.Type
                            
                            // Creamos una copia del objeto inicializada
                            let mirrorAtributo = Mirror(reflecting: attrObj.init())
                            
                            // Realizamos llamada recursiva con: la copia del objeto, el array del json y la instancia del objeto.
                            let atributo = parse(with: mirrorAtributo, from:  json[property_name][i],to: attrObj.init())
                            
                            //Añadirmos el atributo recuperado al array
                            atributos.append(atributo)
                        }
                        // Asociamos el array al atributo de la clase.
                        instanciaObjeto.setValue(atributos, forKey: property_name)
                    } else if attr.value is NSObject {
                        // OBJECT:
          
                        // Creamos una copia del objeto, para recuperar el tipo
                        let mirrorAtribute = Mirror(reflecting: attr.value)
                        
                        // A partir del método privado y la copia, recuperamos el tipo dea clase.
                        let tipoAtributo = String(describing: mirrorAtribute.subjectType)
                        
                        // Creamos un objeto a partir del nombre de la clase
                        let attrObj = NSClassFromString(tipoAtributo) as! NSObject.Type
                        
                        // Creamos una copia del objeto inicializada
                        let mirrorAtributo = Mirror(reflecting: attrObj.init())
                        
                        // Realizamos llamada recursiva con: la copia del objeto, el array del json y la instancia del objeto.
                        let atributo = parse(with: mirrorAtributo, from:  json[property_name],to: attrObj.init())

                        // Asociamos el array al atributo de la clase.
                        instanciaObjeto.setValue(atributo, forKey: property_name)
                    }
                }
            }
            //Devolvemos el objeto de nuestra clase con los atriutos inicializados a partir del JSON
            return instanciaObjeto
        }
        // Nil en caso de la entrada ser nil
        return nil
    }
    
    /// Función que permite imprimir todos los atributos y valores para un objeto tipo JSON que contenga ARRAYS de otros objetos
    /// Sí FUNCIONA
    /// Ejemplo de llamada:
    /// - Usuario(id: usuarioJSON["id"].int!, nombre: usuarioJSON["nombre"].string!, apellidos: usuarioJSON["apellidos"].string!, correo: usuarioJSON["correo"].string!, password: usuarioJSON["password"].string!, roles: roles, imagen: nil)
    ///
    /// - Parseador.shared.listPropertiesWithValues(reflect: Mirror(reflecting: objeto))
    func listPropertiesWithValues(reflect: Mirror? = nil) {
        //let reflect = reflect ?? Mirror(reflecting: self)
        if reflect != nil{
            if reflect!.superclassMirror != nil {
                listPropertiesWithValues(reflect: reflect!.superclassMirror)
            }
            
            for (index, attr) in reflect!.children.enumerated() {
                
                
                
                if let array = attr.value as? [NSObject] {
                    if let property_name = attr.label as String! {
                        
                        print("\(reflect!.description) \(index): \(property_name) =")
                    }
                    
                    for i in 0..<array.count{
                        let mirrorAtribute = Mirror(reflecting: array[i])
                        listPropertiesWithValues(reflect: mirrorAtribute)
                    }
                    
                } else {
                    
                    
                    
                    if let property_name = attr.label as String! {
                        //You can represent the results however you want here!!!
                        
                        
                        print("\(reflect!.description) \(index): \(property_name) = \(attr.value)")
                        
                        
                    }
                }
            }
        }
    }
    
    
    ///Esta clase permite obtener el nombre de una clase
    ///a partir del string.
    /// - parameter mirrorSubjectType:  String generado por el método "mirror.subjectType"
    ///                                 cuando éste devuelve una estructura en el formato:
    ///                                     "Optional < Array< CLASE > >"
    ///                                 Donde CLASE es el nombre de la clase que queremos recuperar.
    /// - returns: String con el nombre de la clase que compone el elemento del array.
    func getClassName(mirrorSubjectType : String) ->String{
        //Array con los tipos que componen el string.
        let arrayTipos = mirrorSubjectType.components(separatedBy: "<")
        
        //Array con el tipo de la CLASE que queremos recuperar. Contiene todos los símbolos ">" restantes al final.
        let toReturn = arrayTipos[arrayTipos.count - 1]
        
        //Devolvemos el tipo sin los símbolos ">"
        return toReturn.components(separatedBy: ">")[0]
    }
}


