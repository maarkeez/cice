//
//  DMDTiendaDetalle.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 5/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDTiendaDetalle: UIViewController {
    
    //MARK: - Variables locales
    var tienda : Tienda!
    
    @IBOutlet weak var myImagen: UIImageView!
    @IBOutlet weak var myNombreTienda: UILabel!
    @IBOutlet weak var myTelefonoTienda: UILabel!
    
    
    @IBAction func mostrarProductos(_ sender: Any) {
        let almacenVC : DMDAlmacenTablaCollection = self.storyboard?.instantiateViewController(withIdentifier: "AlmacenTablaCollection") as! DMDAlmacenTablaCollection
        almacenVC.tienda = self.tienda
        self.navigationController?.pushViewController(almacenVC, animated: true)
        
        
    }
    
    @IBAction func mostrarPedidos(_ sender: Any) {
        
    }
    
    @IBAction func mostrarInventarios(_ sender: Any) {
        //DMDInventarioTabla
        let inventarioVC : DMDInventarioTabla = self.storyboard?.instantiateViewController(withIdentifier: "InventarioTabla") as! DMDInventarioTabla
        
        
        
        inventarioVC.tienda = self.tienda
        
        
        self.navigationController?.pushViewController(inventarioVC, animated: true)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIBOutlets()
        self.title = tienda.nombre
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initIBOutlets(){
        
        if ( tienda.imagen.imagenUI != nil) {
            myImagen.image = tienda.imagen.imagenUI
        }else{
            myImagen.image = UIImage(named: "dummy_shop.png")
        }
        myNombreTienda.text = tienda.nombre
        myTelefonoTienda.text = tienda.telefono
    }
    
}
