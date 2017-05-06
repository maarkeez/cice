//: Playground - noun: a place where people can play

import UIKit

/*
 
 Shared - Standard - Default -> Singleton: Patrón de diseño de iOS de mi aplicación
 
- ¿Cómo identificamos los protocolos delegados?
    Mediante las palabras:
        Should - Did - Will
- NotificationCenter.addObserver: Notifica
 
 
 */

//Creamos la variable para guardar los datos
let prefs = UserDefaults.standard
//Creamos los datos que queremos guardar
let myData = Data()
let myStrig = String()
let myDate = Date()
let myArray = [String]()
let myDiccionario = [String:String]()
let myInt = 8
let myDouble = 5.2
let myFloat = 8.21

// Guardar los datos, accediendo a ellos con una clave posteriormente
prefs.setValue(myData, forKey: "myData")
prefs.setValue(myStrig, forKey: "myStrig")
prefs.setValue(myDate, forKey: "myDate")
prefs.setValue(myArray, forKey: "myArray")
prefs.setValue(myDiccionario, forKey: "myDiccionario")
prefs.setValue(myInt, forKey: "myInt")
prefs.setValue(myDouble, forKey: "myDouble")
prefs.setValue(myFloat, forKey: "myFloat")

//Recuperamos los valores en BYTES
if let myDataDesempaquetado = prefs.data(forKey: "myData"){
    
}


// Recuperamos los valores comprobando que sea nuestro tipo.
if let myDateDesempaquetado = prefs.object(forKey: "myDate") as? Date{
    
}

