//: Playground - noun: a place where people can play

import UIKit

protocol Luchador{
    func luchar()
}

/*
 //Primera forma de implementar un delegado
class Persona : Luchador{
    func luchar() {
        print("Pues te pego un sopapo")
        
    }
}
 */
class Persona{
    
}

extension Persona : Luchador{
    func  luchar() {
        print("Pues te pego un sopapo")
    }
    
    
}

let yo = Persona()
yo.luchar()
