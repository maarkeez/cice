//
//  utils.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 21/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//
/**
    Descripción: En este fichero se incluyen todas las funciones genéricas que permiten el funcionamiento global de la herramienta.
 
 */
import UIKit
import Foundation

let TAMANIO_ESQUINAS : Int = 10

func GenerarProductos() -> [Producto] {
    //Variable a rellenar con los productos
    var productos : [Producto] = []
    
    
    for i in 0 ..< 20  {
        let producto : Producto = Producto() //id: "\(i)", nombre: "nombre_\(i)", categoria: i%5, peso: 100.0 * Float(i), precioCoste: Float(i) * 1.0 , precioPVP: Float(i) * 2.0, IVA : 21.0)
        producto.id = i
        producto.nombre = "nombre_\(i)"
        producto.propiedades.precioCoste = Float(i) * 1.0
        producto.propiedades.precioVentaPublico = Float(i) * 2.0
        producto.propiedades.IVA = 21.0
        productos.append(producto)
    }
    
    
    //Devolvemos un array de productos
    return productos
}

func setSombras(objeto : UIView, opacidad : Float){
    objeto.layer.shadowColor = UIColor.black.cgColor
    objeto.layer.shadowOpacity = opacidad
    objeto.layer.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
    objeto.layer.shadowRadius = CGFloat(5)
}

func redondearEsquinasInferiores( etiqueta : UILabel){
    // Creamos un path que establezca las características para los bordes
    let path = UIBezierPath(roundedRect:etiqueta.bounds,
                            byRoundingCorners:[.bottomLeft, .bottomRight],
                            cornerRadii: CGSize(width: TAMANIO_ESQUINAS, height:  TAMANIO_ESQUINAS))
    //Creamos una máscara para el layer de la etiqueta
    let maskLayer = CAShapeLayer()
    //Asignamos el path a la máscara
    maskLayer.path = path.cgPath
    //Establecemos la máscara, como máscara de la etiqueta
    etiqueta.layer.mask = maskLayer
}

func redondearEsquinasSuperiores(etiqueta : UILabel){
    // Creamos un path que establezca las características para los bordes
    let path = UIBezierPath(roundedRect:etiqueta.bounds,
                            byRoundingCorners:[.topLeft, .topRight],
                            cornerRadii: CGSize(width: TAMANIO_ESQUINAS, height:  TAMANIO_ESQUINAS))
    //Creamos una máscara para el layer de la etiqueta
    let maskLayer = CAShapeLayer()
    //Asignamos el path a la máscara
    maskLayer.path = path.cgPath
    //Establecemos la máscara, como máscara de la etiqueta
    etiqueta.layer.mask = maskLayer
}

func redondearTodasEsquinas(etiqueta : UILabel, tamanio : Int){
    
    // Creamos un path que establezca las características para los bordes
    let path = UIBezierPath(roundedRect:etiqueta.bounds,
                            byRoundingCorners:[.topLeft, .topRight,.bottomLeft,.bottomRight],
                            cornerRadii: CGSize(width: tamanio, height:  tamanio))
    //Creamos una máscara para el layer de la etiqueta
    let maskLayer = CAShapeLayer()
    //Asignamos el path a la máscara
    maskLayer.path = path.cgPath
    //Establecemos la máscara, como máscara de la etiqueta
    etiqueta.layer.mask = maskLayer
}
