//
//  DMDInventarioNav.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 8/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class DMDInventarioNav: UINavigationController {
    
    
    var viewController : DMDListaRecibirPedido?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar componente genérico
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        viewController = mainStoryBoard.instantiateViewController(withIdentifier: "DMDListaRecibirPedido") as! DMDListaRecibirPedido
        
        //Asignar como delegado
        viewController?.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([viewController!], animated: true)
    }
    
    func toStock(pedidoProductos : [PedidoProductos]) -> [Stock]{
        var listado = [Stock]()
        
        for pedidoProducto in pedidoProductos {
            
            let stock = Stock(id: nil,
                              tienda: Session.shared.tiendaSeleccionada,
                              producto: pedidoProducto.producto,
                              cantidad: Int(pedidoProducto.cantidad)
            )
            
            listado.append(stock)
        }
        return listado
    }
    
    
}

extension DMDInventarioNav : DMDListaRecibirPedidoDelegate{
    
    func setPedidoProductos(_ lista: [PedidoProductos]){
        let stocks = toStock(pedidoProductos: lista)
        var contador = stocks.count
        
        for stock in stocks {
            StockService.shared.edit(stock: stock, callback: { (stock) in
                print("Actualizado stock id:\(stock!.id!) (\(stock!.cantidad!)) en tienda \(stock!.tienda!.nombre!)")
                contador -= 1
                
                if contador == 0 {
                    showDMDConfirm(self)
                }
                
            })
        }
    }
    
    func getPedidoProductos() -> [PedidoProductos]{
        return []
    }
    
    func dismissNav() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DMDInventarioNav : DMDConfirmDelegate{
    func confirmar(){
        
    }
    func cancelar(){}
    
    func getTitulo() -> String{
        return "Información"
    }
    func getTexto() -> String{
        return "Su inventario ha sido registrado correctamente"
    }
}
