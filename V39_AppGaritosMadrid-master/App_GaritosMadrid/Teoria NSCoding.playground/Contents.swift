//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class Persona : NSObject, NSCoding {
    
    var nombre : String
    var apellido : String
    var direccion : String
    var email : String
    
    init( nombre : String, apellido : String, direccion : String, email : String ){
        self.nombre = nombre
        self.apellido = apellido
        self.direccion = direccion
        self.email = email
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let nombre = aDecoder.decodeObject(forKey: "nombre") as! String
        let apellido = aDecoder.decodeObject(forKey: "apellido") as! String
        let direccion = aDecoder.decodeObject(forKey: "direccion") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        
        self.init(nombre : nombre, apellido : apellido, direccion : direccion, email : email )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.nombre, forKey: "nombre")
        aCoder.encode(self.apellido, forKey: "apellido")
        aCoder.encode(self.direccion, forKey: "direccion")
        aCoder.encode(self.email, forKey: "email")
    }
    
}

var multitud = [Persona]()

multitud.append(Persona(nombre: "Nombre 1", apellido: "Appellido 1", direccion: "Dir 1", email: "email1@email.com"))
multitud.append(Persona(nombre: "Nombre 2", apellido: "Appellido 2", direccion: "Dir 2", email: "email2@email.com"))
multitud.append(Persona(nombre: "Nombre 3", apellido: "Appellido 3", direccion: "Dir 3", email: "email3@email.com"))

func dataBaseUrl () -> URL? {
    
    if let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first{
        let urlDirectorio = URL(fileURLWithPath: documentDirectory)
        return urlDirectorio.appendingPathComponent("multitud.data")
    }
    return nil
}

func guardarInfo() {
    if let pathMultitudData = dataBaseUrl(){
        NSKeyedArchiver.archiveRootObject(multitud, toFile: pathMultitudData.path)
        print("Datos guardados en: ")
        print(pathMultitudData.path)
    }else{
        print("Error guardando los datos. No existe la ruta para multitud.data")
    }
}

func getInfo() {
    
    if let pathMultitudData = dataBaseUrl(),let datosMultitud = NSKeyedUnarchiver.unarchiveObject(withFile: pathMultitudData.path) as? [Persona]{
            multitud = datosMultitud
    }else{
        print("Error recuperando los datos para multitud.data")
    }
    
}

//1
guardarInfo()
//2
multitud.removeAll()
//3
getInfo()
//4
for persona in multitud {
    print("Nombre: \(persona.nombre)" )
}












