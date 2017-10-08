//
//  DMDStockNav.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 8/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class DMDStockNav: UINavigationController {
    
    
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        StockService.shared.todos((Session.shared.tiendaSeleccionada?.id!)!) { (stocks) in
            let pedidoProductos = self.toPedidoProductos(stocks)
            
            self.viewController?.addProductos(pedidoProductos)
        }
    }
    
    func toPedidoProductos(_ stocks : [Stock]) -> [PedidoProductos] {
        
        var listado = [PedidoProductos]()
        
        for stock in stocks {
            let pedProducto = PedidoProductos(id: nil,
                                              producto: stock.producto,
                                              precioCoste: nil,
                                              precioVentaPublico: nil,
                                              cantidad: Float(stock.cantidad),
                                              inventario: nil,
                                              pedido: nil
            )
            listado.append(pedProducto)
        }
        return listado
    }
    
    
}

extension DMDStockNav : DMDListaRecibirPedidoDelegate{
    
    func setPedidoProductos(_ lista: [PedidoProductos]){
       
    }
    
    func getPedidoProductos() -> [PedidoProductos]{
        return []
    }
    
    func dismissNav() {
        self.dismiss(animated: true, completion: nil)
    }
}
