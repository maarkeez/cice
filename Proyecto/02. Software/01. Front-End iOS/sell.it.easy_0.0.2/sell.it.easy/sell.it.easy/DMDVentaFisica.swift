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
    var vendedor : Usuario?
    var fecha : Date?
    
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
        setVendedor(Session.shared.usuario)
        setFechaActual(Date())
        setTotal(0)
        setCantidadProductos(0)
        
    }
    
    func setVendedor(_ usuario: Usuario) {
        myNombreVendedor.text = usuario.nombre
        vendedor = usuario
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
}
