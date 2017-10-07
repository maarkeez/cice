//
//  DMDVentaFisicaDetalle.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 7/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import Foundation

class DMDVentaFisicaDetalle: UINavigationController {
    
    var viewController : DMDTablaDinamicaCG?
    var ventaFisica : VentaFisica?
    var productos = [PedidoProductos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar componente genérico
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        viewController = mainStoryBoard.instantiateViewController(withIdentifier: "DMDTablaDinamicaCG") as! DMDTablaDinamicaCG
        
        //Asignar como delegado
        viewController?.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([viewController!], animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        PedidoProductosService.shared.findByPedido_id((ventaFisica?.pedido?.id)!) { (pedidoProductos) in
            self.productos = pedidoProductos
            self.showData()
        }
    }
    
    func showData(){
        viewController?.data = getData()
        viewController?.myTable.reloadData()
    }
}

extension DMDVentaFisicaDetalle :  DMDTablaDinamicaCGDelegate {
    
    func setData(_ data: DMDTablaDataCG){
    }
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        
        // 1. - Nombre de la tienda
        data.listaItems.append(DMDCeldaLabel(nombre: "Tienda", texto: (ventaFisica?.pedido?.tienda?.nombre)!))
        
        // 2. - Nombre de la tienda
        data.listaItems.append(DMDCeldaLabel(nombre: "Fecha compra", texto: (ventaFisica?.pedido?.fechaCierre?.stringValue)!))
        
        // 3. - Tipo de pago
        data.listaItems.append(DMDCeldaLabel(nombre: "Tipo de pago", texto: (ventaFisica?.pedido?.tipoPago?.nombre)!))
        
        
        // 3. - Tipo de compra
        data.listaItems.append(DMDCeldaLabel(nombre: "Tipo de compra", texto: (ventaFisica?.pedido?.tipoCompra?.nombre)!))
        
        // 4. - Vendedor
        data.listaItems.append(DMDCeldaLabel(nombre: "Vendedor", texto: (ventaFisica?.vendedor?.nombre)!))
        
        var totalPVP : Float = 0.0
        for producto in productos {
            
            totalPVP = totalPVP + producto.precioVentaPublico! * producto.cantidad
            
            let nombreProducto : String = producto.producto.nombre!
            let cantidadProducto : Float = producto.cantidad!
            
            let nombre = "\(nombreProducto) (\(cantidadProducto))"
            let pvp : Float = producto.precioVentaPublico!
            let precio = "\(pvp) €"
            
            // - Productos
            data.listaItems.append(DMDCeldaLabel(nombre: nombre, texto: precio))
        }
        
        // - Total venta
        data.listaItems.append(DMDCeldaLabel(nombre: "Total (€)", texto: "\(totalPVP)"))
        
        
        //Permitir guardado
        data.guardar = false
        data.isBackButton = true
        
        return data
    }
    
    
}


