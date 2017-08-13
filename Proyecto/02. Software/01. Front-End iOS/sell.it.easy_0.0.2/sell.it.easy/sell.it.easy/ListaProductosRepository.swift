////
////  ListaProductosRepository.swift
////  sell.it.easy
////
////  Created by David Márquez Delgado on 15/5/17.
////  Copyright © 2017 David Márquez Delgado. All rights reserved.
////
//
//import Foundation
//import CoreData
//
//class ListaProductosRepository {
//    
//    //MARK: - Variables locales
//    ///Acceso a CordeData local
//    let stack = CoreDataStack.shared
//    
//    //Tipos
//    let TIPO_INVENTARIO : Int32 = 0
//    let TIPO_PEDIDO : Int32  = 1
//    let TIPO_RECEPCION_PEDIDO : Int32  = 2
//    let TIPO_COMPRA_FISICA : Int32  = 3
//    let TIPO_COMPRA_ONLINE : Int32  = 4
//    
//    ///Singleton
//    static let shared = ListaProductosRepository()
//    
//    ///Guarda o actualiza si existe.
//    ///Actualiza buscando por ID y al primero que encuentre
//    func save(_ productoLista: ListaProductos){
//        let ctx = stack.persistentContainer.viewContext
//        var productoListaAGuardar : ListaProductos?
//        if let productoListaAntiguo = findById(productoLista.id){
//            //Si ya existe, actualizar
//            productoListaAGuardar = copyAttributesExceptId(from: productoLista, to: productoListaAntiguo)
//            
//            
//            
//        }else{
//            //Si no existe, crear
//            productoListaAGuardar = productoLista
//        }
//        
//        do{
//            try ctx.save()
//        } catch let error {
//            print("ListaProductosRepository.save Error:  \(error.localizedDescription)")
//        }
//        
//    }
//    
//    ///Recupera un producto a partir de su ID
//    ///Si hay varios, recupera la primera entrada
//    func findById(_ id: Int32) -> ListaProductos?{
//        let ctx = stack.persistentContainer.viewContext
//        let request : NSFetchRequest<ListaProductos> = ListaProductos.fetchRequest()
//        let condicion = NSPredicate(format: "id = '\(id)'")
//        request.predicate = condicion
//        
//        do{
//            let tiendas = try ctx.fetch(request)
//            
//            if tiendas.count > 0 {
//                return tiendas.first
//            }
//            return nil
//            
//        }catch let error{
//            print("ListaProductosRepository.findById: Error consultando CoreData \(error.localizedDescription)")
//            return nil
//        }
//    }
//    
//    ///Recupera un listado de producto a partir de su ID de lista
//    func findByIdLista(_ id: Int32) -> [ListaProductos]{
//        let ctx = stack.persistentContainer.viewContext
//        let request : NSFetchRequest<ListaProductos> = ListaProductos.fetchRequest()
//        let condicion = NSPredicate(format: "id = '\(id)'")
//        request.predicate = condicion
//        
//        do{
//            return try ctx.fetch(request)
//            
//        }catch let error{
//            print("ListaProductosRepository.findById: Error consultando CoreData \(error.localizedDescription)")
//            return []
//        }
//    }
//    
//    ///Recupera todos los productos
//    func findAll() -> [ListaProductos]{
//        let ctx = stack.persistentContainer.viewContext
//        let request : NSFetchRequest<ListaProductos> = ListaProductos.fetchRequest()
//        
//        do{
//            return try ctx.fetch(request)
//                        
//        }catch let error{
//            print("ListaProductosRepository.findAll: Error consultando CoreData \(error.localizedDescription)")
//            return []
//        }
//    }
//    
//    ///Recupera todos los productos ordenados por fecha guardado DESC y fecha cancelado DESC
//    func findAllOrderByFecha() -> [ListaProductos]{
//        let ctx = stack.persistentContainer.viewContext
//        let request : NSFetchRequest<ListaProductos> = ListaProductos.fetchRequest()
//        let sortDescription1 = NSSortDescriptor(key: "fechaGuardado", ascending: false)
//        let sortDescription2 = NSSortDescriptor(key: "fechaCancelado", ascending: false)
//        request.sortDescriptors = [sortDescription1,sortDescription2]
//        
//        do{
//            return try ctx.fetch(request)
//            
//        }catch let error{
//            print("ListaProductosRepository.findAllOrderByFecha: Error consultando CoreData \(error.localizedDescription)")
//            return []
//        }
//    }
//    
//    ///Copia todas los atributos de un producto a otro excepto el ID.
//    func copyAttributesExceptId(from: ListaProductos, to: ListaProductos) -> ListaProductos {
//        
//        to.cantidad = from.cantidad
//        to.fechaGuardado = from.fechaGuardado
//        to.fechaConfirmado = from.fechaConfirmado
//        to.tipo = from.tipo
//        to.listaproductos2producto = from.listaproductos2producto
//        
//        return to
//        
//        
//    }
//    
//    func deleteById(_ id: Int32){
//        let ctx = stack.persistentContainer.viewContext
//        let tienda = findById(id)
//        
//        if let objeto = tienda {
//            ctx.delete(objeto)
//        }
//        
//    }
//    
//    func findByTipo(_ tipo: Int32) -> [ListaProductos] {
//        let ctx = stack.persistentContainer.viewContext
//        let request : NSFetchRequest<ListaProductos> = ListaProductos.fetchRequest()
//        let condicion = NSPredicate(format: "tipo = \(tipo)")
//        request.predicate = condicion
//        
//        do{
//            return try ctx.fetch(request)
//            
//            
//            
//        }catch let error{
//            print("ListaProductosRepository.findByTipo: Error consultando CoreData \(error.localizedDescription)")
//            
//        }
//        
//        return []
//    }
//    
//    
//    
//    func new() -> ListaProductos{
//        let tienda = ListaProductos(context: stack.persistentContainer.viewContext)
//        tienda.id = Int32(UUID().hashValue)
//        return tienda
//        
//    }
//}
