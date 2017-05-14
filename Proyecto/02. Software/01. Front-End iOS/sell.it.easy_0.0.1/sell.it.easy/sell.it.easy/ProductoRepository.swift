//
//  ProductoRepository.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 14/5/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import CoreData

class ProductoRepository {
    
    //MARK: - Variables locales
    ///Acceso a CordeData local
    let stack = CoreDataStack.shared
    ///Singleton
    static let shared = ProductoRepository()
    
    ///Guarda o actualiza un producto si existe. 
    ///Actualiza buscando por ID y al primero que encuentre
    func save(_ producto: Producto){
        let ctx = stack.persistentContainer.viewContext
        var productoAGuardar : Producto?
        if let productoAntiguo = findById(producto.id){
            //Si ya existe, actualizar
            productoAGuardar = copyAttributesExceptId(from: producto, to: productoAntiguo)
            
            
            
        }else{
            //Si no existe, crear
            productoAGuardar = producto
        }
        
        do{
            try ctx.save()
        } catch let error {
            print("ProductoRepository.save:  \(error.localizedDescription)")
        }
        
    }
    
    ///Recupera un producto a partir de su ID
    ///Si hay varios, recupera la primera entrada
    func findById(_ id: Int32) -> Producto?{
        let ctx = stack.persistentContainer.viewContext
        let request : NSFetchRequest<Producto> = Producto.fetchRequest()
        let condicion = NSPredicate(format: "id = '\(id)'")
        request.predicate = condicion
        
        do{
            let productos = try ctx.fetch(request)
            
            if productos.count > 0 {
                return productos.first
            }
            return nil
            
        }catch let error{
            print("ProductoRepository.getById: Error consultando CoreData \(error.localizedDescription)")
            return nil
        }
    }
    
    ///Recupera todos los productos
    func findAll() -> [Producto]{
        let ctx = stack.persistentContainer.viewContext
        let request : NSFetchRequest<Producto> = Producto.fetchRequest()
        
        do{
            let productos = try ctx.fetch(request)

            return productos
            
        }catch let error{
            print("ProductoRepository.getById: Error consultando CoreData \(error.localizedDescription)")
            return []
        }
    }
    
    ///Recupera todos los productos ordenados por nombre
    func findAllOrderByNombre() -> [Producto]{
        let ctx = stack.persistentContainer.viewContext
        let request : NSFetchRequest<Producto> = Producto.fetchRequest()
        let sortDescription = NSSortDescriptor(key: "nombre", ascending: true)
        request.sortDescriptors = [sortDescription]
        
        do{
            let productos = try ctx.fetch(request)
            
            return productos
            
        }catch let error{
            print("ProductoRepository.getById: Error consultando CoreData \(error.localizedDescription)")
            return []
        }
    }
    
    ///Copia todas los atributos de un producto a otro excepto el ID.
    func copyAttributesExceptId(from: Producto, to: Producto) -> Producto {
        to.codigoBarras = from.codigoBarras
        to.codigoEmpresa = from.codigoEmpresa
        to.descripcion = from.descripcion
        to.descuento = from.descuento
        to.imagen = from.imagen
        to.nombre = from.nombre
        to.precioCoste = from.precioCoste
        to.pvp = from.pvp
        to.talla = from.talla
        
        return to
        
        
    }
    
    func new() -> Producto{
        let producto = Producto(context: stack.persistentContainer.viewContext)
        producto.id = Int32(UUID().hashValue)
        return producto
        
    }
}
