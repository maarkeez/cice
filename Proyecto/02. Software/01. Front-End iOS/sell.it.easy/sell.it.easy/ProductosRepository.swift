//
//  ProductosRepository.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 6/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//
import UIKit
import Foundation

class ProductosRepository {
    static let shared = ProductosRepository()
    var productos : [Producto] = []
    
    func findAll() -> [Producto] {
        productos = dummy()
        return  productos
        
        
    }
    
    func findAllByTienda(tienda: Tienda) -> [Producto] {
        productos = dummy()
        return productos
    }
    
    func dummy() -> [Producto]{
        var productos : [Producto] = []
        for i in 0 ..< 5  {
            let producto  : Producto = Producto()
            producto.nombre = "Nombre_\(i)"
            producto.descripcion = "Descripción_\(i)"
            producto.tipoProducto = TipoProducto()
            let propiedades = PropiedadProducto()
            propiedades.imagen.imagenUI = UIImage(named: "not_available.png")
            producto.propiedades = propiedades
            productos.append(producto)
            
        }
        return productos
    }
}
