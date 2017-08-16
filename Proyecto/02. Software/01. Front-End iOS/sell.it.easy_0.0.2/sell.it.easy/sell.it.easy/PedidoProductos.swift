//
//  PedidoProductos.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 17/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation
import ObjectMapper

class PedidoProductos: Mappable{
    /*
     
     @Id
     @GeneratedValue(strategy=GenerationType.AUTO)
     private Integer id;
     @ManyToOne(optional=false)
     private Producto producto;
     private Float precioCoste;
     private Float precioVentaPublico;
     @Column(nullable=false)
     private Float cantidad;
     
     @ManyToOne(optional=true)
     private Inventario inventario;
     
     @ManyToOne(optional=true)
     private Pedido pedido;
     */
    var id : Int?
    var producto : Producto!
    var precioCoste : Float?
    var precioVentaPublico : Float?
    var cantidad : Float!
    var inventario : Inventario?
    var pedido : Pedido?
    
    init(id: Int?, producto: Producto!, precioCoste: Float?, precioVentaPublico: Float?, cantidad: Float!, inventario: Inventario?, pedido: Pedido?) {
        self.id = id
        self.producto = producto
        self.precioCoste = precioCoste
        self.precioVentaPublico = precioVentaPublico
        self.cantidad = cantidad
        self.inventario = inventario
        self.pedido = pedido
    }
    
   
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        producto <- map["producto"]
        precioCoste <- map["precioCoste"]
        precioVentaPublico <- map["precioVentaPublico"]
        cantidad <- map["cantidad"]
        inventario <- map["inventario"]
        pedido <- map["pedido"]
    }
}
