//
//  DMDDetalleProductoVC.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 22/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDDetalleProductoVC: UIViewController {
    
    //MARK : - Variables locales
       var producto : Producto?
    
    //MARK : - IBOutlets
    //Variables del producto
    @IBOutlet weak var miImagen: UIImageView!
    @IBOutlet weak var miNombre: UILabel!
    @IBOutlet weak var miIdentificador: UILabel!
    @IBOutlet weak var miCategoria: UILabel!
    @IBOutlet weak var miPrecioPVP: UILabel!
    @IBOutlet weak var miDescuento: UILabel!
    @IBOutlet weak var miDescripcion: UILabel!
    @IBOutlet weak var miLote: UILabel!
    @IBOutlet weak var miCaducidad: UILabel!
    @IBOutlet weak var miPeso: UILabel!
    @IBOutlet weak var miPrecioCoste: UILabel!
    @IBOutlet weak var miTotalProductos: UILabel!
    @IBOutlet weak var miIVA: UILabel!
    
    //Estaticos
    @IBOutlet weak var miImagenView: UIView!
    @IBOutlet weak var lblCategoria: UILabel!
    @IBOutlet weak var lblPrecioPVP: UILabel!
    @IBOutlet weak var lblDescuento: UILabel!
    @IBOutlet weak var lblLote: UILabel!
    @IBOutlet weak var lblCaducidad: UILabel!
    @IBOutlet weak var lblPeso: UILabel!
    @IBOutlet weak var lblPrecioCoste: UILabel!
    @IBOutlet weak var lblTotalProductos: UILabel!
    @IBOutlet weak var lblIVA: UILabel!
    @IBOutlet weak var btnAddProducto: UIButton!
    @IBOutlet weak var btnQuitarProducto: UIButton!
    //MARK : - IBActions
   
    
    //MARK : - Life VC
    override func viewDidLoad() {
        super.viewDidLoad()
        setIBOutlets(producto: self.producto!)
        setIBOutletsStyle()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setIBOutlets(producto: Producto) {
        miPrecioCoste.text = "\(producto.propiedades.precioCoste) €"
        miPrecioPVP.text = "\(producto.propiedades.precioVentaPublico) €"
        miIVA.text = "\(producto.propiedades.IVA) %"
        miNombre.text = producto.nombre
        miDescripcion.text = producto.descripcion
        miIdentificador.text = String(producto.id)
    }
    
    func setIBOutletsStyle(){
        // ---------------------------------------------------------
        // Redondeamos esquinas superiores e inferiores
        // ---------------------------------------------------------
        //Imagen
        miImagen.layer.cornerRadius = CGFloat(TAMANIO_ESQUINAS)
        miImagenView.layer.cornerRadius = CGFloat(TAMANIO_ESQUINAS)
        //Nombre e indentificador
        redondearTodasEsquinas(etiqueta: miNombre,tamanio: 5)
        redondearTodasEsquinas(etiqueta: miIdentificador,tamanio: 5)
        //Descripcion
        redondearTodasEsquinas(etiqueta: miDescripcion,tamanio: TAMANIO_ESQUINAS)
        //Boton
        btnAddProducto.layer.cornerRadius = CGFloat(TAMANIO_ESQUINAS)
        btnQuitarProducto.layer.cornerRadius = CGFloat(TAMANIO_ESQUINAS)
        
        // ---------------------------------------------------------
        //Redondeamos las esquinas superiores
        // ---------------------------------------------------------
        redondearEsquinasSuperiores(etiqueta: lblCategoria)
        redondearEsquinasSuperiores(etiqueta: lblPrecioPVP)
        redondearEsquinasSuperiores(etiqueta: lblDescuento)
        redondearEsquinasSuperiores(etiqueta: lblLote)
        redondearEsquinasSuperiores(etiqueta: lblCaducidad)
        redondearEsquinasSuperiores(etiqueta: lblPeso)
        redondearEsquinasSuperiores(etiqueta: lblPrecioCoste)
        redondearEsquinasSuperiores(etiqueta: lblTotalProductos)
        redondearEsquinasSuperiores(etiqueta: lblIVA)
        
        // ---------------------------------------------------------
        //Redondeamos las esquinas inferiores
        // ---------------------------------------------------------
        redondearEsquinasInferiores(etiqueta: miCategoria)
        redondearEsquinasInferiores(etiqueta: miPrecioPVP)
        redondearEsquinasInferiores(etiqueta: miDescuento)
        redondearEsquinasInferiores(etiqueta: miLote)
        redondearEsquinasInferiores(etiqueta: miCaducidad)
        redondearEsquinasInferiores(etiqueta: miPeso)
        redondearEsquinasInferiores(etiqueta: miPrecioCoste)
        redondearEsquinasInferiores(etiqueta: miTotalProductos)
        redondearEsquinasInferiores(etiqueta: miIVA)
        
        // ---------------------------------------------------------
        // Cambios el color de los textos
        // ---------------------------------------------------------
        //lblCategoria.textColor = UIColor.white
        //lblPrecioPVP.textColor = UIColor.white
        //lblDescuento.textColor = UIColor.white
        //lblLote.textColor = UIColor.white
        //lblPeso.textColor = UIColor.white
        //lblPrecioCoste.textColor = UIColor.white
        //lblTotalProductos.textColor = UIColor.white
        //lblIVA.textColor = UIColor.white
        
        // Sombras
        setSombras(objeto: miImagenView, opacidad: 0.7)
        setSombras(objeto: btnAddProducto, opacidad: 0.2)
        setSombras(objeto: btnQuitarProducto, opacidad: 0.2)
        setSombras(objeto: miImagen, opacidad: 0.7)
    }
    
   
    
    
    

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
