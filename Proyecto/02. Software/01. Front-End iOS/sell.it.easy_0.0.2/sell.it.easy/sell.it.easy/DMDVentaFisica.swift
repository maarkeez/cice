//
//  DMDVentaFisica.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 16/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDVentaFisica: UIViewController {
    
    //MARK: - Variables locales
    var ventaFisica : VentaFisica?
    var productos = [PedidoProductos]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myNombreVendedor: UILabel!
    @IBOutlet weak var myFecha: UILabel!
    @IBOutlet weak var myTotalPagar: UILabel!
    @IBOutlet weak var myCantidadProductos: UILabel!
    @IBOutlet weak var myDescartarBTN: UIButton!
    @IBOutlet weak var myConfirmarBTN: UIButton!
    @IBOutlet weak var myProductosBTN: UIButton!
    
    //MARK: - IBActions
    @IBAction func myDescartarACTION(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func myProductosACTION(_ sender: UIButton) {
        let listadoProductoVC = storyboard?.instantiateViewController(withIdentifier: "DMDListaRecibirPedido") as? DMDListaRecibirPedido
        listadoProductoVC?.delegate = self
        self.navigationController?.pushViewController(listadoProductoVC!, animated: true)
    }
    
    @IBAction func myConfirmarACTION(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cambiar UI Botones
        myConfirmarBTN.layer.cornerRadius = 5
        myDescartarBTN.layer.cornerRadius = 5
        myProductosBTN.layer.cornerRadius = 5
        let origImage = #imageLiteral(resourceName: "uniform")
        let tintedImage = origImage.withRenderingMode(.alwaysTemplate)
        myProductosBTN.setImage(tintedImage, for: .normal)
        myProductosBTN.tintColor = .white
        
        
        //Set Initial IBOutlets
        if ventaFisica == nil {
            setVentaFisica(VentaFisica(id: nil,
                                   fecha: Date(),
                                   vendedor: Session.shared.usuario,
                                   pedido: nil))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showVentaFisica()
    }
    
    func setVentaFisica(_ ventaFisica : VentaFisica){
        self.ventaFisica = ventaFisica
    }
    
    func showVentaFisica(){
        setVendedor((ventaFisica?.vendedor!)!)
        setFechaActual((ventaFisica?.fecha)!)
        setTotal(getTotal())
        setCantidadProductos(getCantidad())
    }
    
    func setVendedor(_ usuario: Usuario) {
        myNombreVendedor.text = usuario.nombre
    }
    
    func setFechaActual(_ fecha: Date){
        myFecha.text = fecha.stringValue
    }
    
    func setTotal(_ total: Float){
        myTotalPagar.text = "\(total)"
    }
    
    func setCantidadProductos(_ total: Float){
        myCantidadProductos.text = "\(total)"
    }
    
    func getTotal() -> Float{
        var total : Float  = 0.0
        
        for producto in productos {
            if let pvp = producto.precioVentaPublico {
                total = total + pvp
            }
        }
        return total
    }
    
    func getCantidad() -> Float{
        var total : Float  = 0.0
        
        for producto in productos {
            if let cantidad = producto.cantidad {
                total = total + cantidad
            }
        }
        return total
    }
}

extension DMDVentaFisica : DMDListaRecibirPedidoDelegate{
    func setPedidoProductos(_ lista: [PedidoProductos]){
        productos = lista
    }
}
