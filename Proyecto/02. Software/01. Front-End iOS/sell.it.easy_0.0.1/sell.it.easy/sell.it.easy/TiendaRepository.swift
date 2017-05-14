//
//  TiendaRepository.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import CoreData

class TiendaRepository {
    
    //MARK: - Variables locales
    ///Acceso a CordeData local
    let stack = CoreDataStack.shared
    ///Singleton
    static let shared = TiendaRepository()
    
    ///Guarda o actualiza una tienda si existe.
    ///Actualiza buscando por ID y al primero que encuentre
    func save(_ tienda: Tienda){
        let ctx = stack.persistentContainer.viewContext
        var tiendaAGuardar : Tienda?
        if let tiendaAntigua = findById(tienda.id){
            //Si ya existe, actualizar
            tiendaAGuardar = copyAttributesExceptId(from: tienda, to: tiendaAntigua)
            
            
            
        }else{
            //Si no existe, crear
            tiendaAGuardar = tienda
        }
        
        do{
            try ctx.save()
        } catch let error {
            print("TiendaRepository.save:  \(error.localizedDescription)")
        }
        
    }
    
    ///Recupera un producto a partir de su ID
    ///Si hay varios, recupera la primera entrada
    func findById(_ id: Int32) -> Tienda?{
        let ctx = stack.persistentContainer.viewContext
        let request : NSFetchRequest<Tienda> = Tienda.fetchRequest()
        let condicion = NSPredicate(format: "id = '\(id)'")
        request.predicate = condicion
        
        do{
            let tiendas = try ctx.fetch(request)
            
            if tiendas.count > 0 {
                return tiendas.first
            }
            return nil
            
        }catch let error{
            print("TiendaRepository.findById: Error consultando CoreData \(error.localizedDescription)")
            return nil
        }
    }
    
    ///Recupera todos los productos
    func findAll() -> [Tienda]{
        let ctx = stack.persistentContainer.viewContext
        let request : NSFetchRequest<Tienda> = Tienda.fetchRequest()
        
        do{
            let tiendas = try ctx.fetch(request)
            
            return tiendas
            
        }catch let error{
            print("findAll: Error consultando CoreData \(error.localizedDescription)")
            return []
        }
    }
    
    ///Recupera todos los productos ordenados por nombre
    func findAllOrderByNombre() -> [Tienda]{
        let ctx = stack.persistentContainer.viewContext
        let request : NSFetchRequest<Tienda> = Tienda.fetchRequest()
        let sortDescription = NSSortDescriptor(key: "nombre", ascending: true)
        request.sortDescriptors = [sortDescription]
        
        do{
            let tiendas = try ctx.fetch(request)
            
            return tiendas
            
        }catch let error{
            print("findAllOrderByNombre: Error consultando CoreData \(error.localizedDescription)")
            return []
        }
    }
    
    ///Copia todas los atributos de un producto a otro excepto el ID.
    func copyAttributesExceptId(from: Tienda, to: Tienda) -> Tienda {

        to.imagen = from.imagen
        to.nombre = from.nombre
        to.telefono = from.telefono
        
        return to
        
        
    }
    
    func new() -> Tienda{
        let tienda = Tienda(context: stack.persistentContainer.viewContext)
        tienda.id = Int32(UUID().hashValue)
        return tienda
        
    }
}
