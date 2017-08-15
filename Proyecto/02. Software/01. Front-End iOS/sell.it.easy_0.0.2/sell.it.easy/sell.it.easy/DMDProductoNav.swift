//
//  DNDProductoNav.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 15/8/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDProductoNav: UINavigationController {
    
    
    var producto = Producto(id: nil , nombre: "", descripcion: "", tipoProducto: nil, propiedades: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recuperar componente genérico
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "DMDTablaDinamicaCG") as! DMDTablaDinamicaCG
        
        //Asignar como delegado
        viewController.delegate = self
        
        //Mostrar el componente genérico con las opciones configuradas.
        self.setViewControllers([viewController], animated: true)
        
    }
    
}

extension DMDProductoNav :  DMDConfirmDelegate {
    func confirmar(){}
    func cancelar(){}
    
    func getTitulo() -> String{
        return ""
    }
    func getTexto() -> String{
        return "Sus cambios se han realizado con éxito"
    }
}


extension DMDProductoNav :  DMDTablaDinamicaCGDelegate {
    
    func setData(_ data: DMDTablaDataCG){
        
        if producto.propiedades != nil {
            producto.propiedades = PropiedadProducto(id: nil,
                                                     talla: nil, // OK
                                                     codigoDeBarras: nil, //OK
                                                     codigoDeEmpresa: nil, // OK
                                                     precioCoste: nil,
                                                     precioVentaPublico: nil,
                                                     descuento: nil,
                                                     imagenString: nil, // OK
                                                     IVA: nil)
        }
        
        if let celda = data.listaItems[0] as? DMDCeldaPerfil {
            producto.nombre = celda.nombre
            
            //Comprobamos si existe imagen para el perfil
            if let imagen = celda.imagen{
                
                var imagenTexto = Utils.shared.getTexto(imagen)
                
                //Comprobamos si la imagen ha cambiado
                if imagenTexto != producto.propiedades?.imagenString {
                    //Comprimir la imagen
                    let imagenComprimida = Utils.shared.comprimirImagen(imagen)
                    
                    //Convertir a texto
                    imagenTexto = Utils.shared.getTexto(imagenComprimida)
                    
                    //Reasignar al usuario
                    producto.propiedades?.imagenString = imagenTexto
                }
            }
            
        }
        
        // 1 - Descripción
        if let celda = data.listaItems[1] as? DMDCeldaLabel {
            producto.descripcion = celda.texto
        }
        
        // 2 - Tipo producto
        if let celda = data.listaItems[2] as? DMDCeldaSelector {
            producto.tipoProducto = TipoProducto(id: celda.indiceSeleccionado, nombre: CONSTANTES.PRODUCTO_TIPOS[celda.indiceSeleccionado])
        }
        
        // 3 - barcode
        if let celda = data.listaItems[3] as? DMDCeldaCodigoBarras {
            producto.propiedades?.codigoDeBarras = celda.codigoBarras
        }

        // 4 - Talla
        if let celda = data.listaItems[4] as? DMDCeldaSelector {
            producto.propiedades?.talla = CONSTANTES.TALLA.LISTADO[celda.indiceSeleccionado]
        }
        
        // 5- Código de empresa
        if let celda = data.listaItems[5] as? DMDCeldaLabel {
            producto.propiedades?.codigoDeEmpresa = celda.texto
        }
        
        // 6 - Precio coste
        if let celda = data.listaItems[6] as? DMDCeldaLabel {
            producto.propiedades?.precioCoste = celda.texto.floatValue
        }
        
        // 7 - PVP
        if let celda = data.listaItems[7] as? DMDCeldaLabel {
            producto.propiedades?.precioVentaPublico = celda.texto.floatValue
        }
        
        // 8 - Descuento
        if let celda = data.listaItems[8] as? DMDCeldaLabel {
            producto.propiedades?.descuento = celda.texto.floatValue
        }
        
        // 9 - IVA
        if let celda = data.listaItems[9] as? DMDCeldaLabel {
            producto.propiedades?.IVA = celda.texto.floatValue
        }
        

        
        
        if producto.id != nil{
            ProductoService.shared.editar(producto) { (producto) in
                if producto != nil {
                    showDMDConfirm(self)
                }
            }
        }else{
            ProductoService.shared.alta(producto) { (producto) in
                if producto != nil {
                    showDMDConfirm(self)
                }
            }
        }
    }
    
    func getData() -> DMDTablaDataCG {
        let data = DMDTablaDataCG()
        
        // 0 - Celda de perfil
        let blue_background = #imageLiteral(resourceName: "blue-background")
        var imagen = #imageLiteral(resourceName: "uniform")
        
        if let imagenString = producto.propiedades?.imagenString {
            imagen = Utils.shared.getImagen(imagenString)!
        }
        data.listaItems.append(DMDCeldaPerfil(imagen: imagen, nombre: producto.nombre!, fondo: blue_background))
        
        // 1 - Descripción
        data.listaItems.append(DMDCeldaTextoLargo(nombre: "Descripción", texto: producto.descripcion))
        
        // 2 - Tipo producto
        var indiceTipo = 0
        if let tipo = producto.tipoProducto {
            indiceTipo = tipo.id!
        }
        data.listaItems.append(DMDCeldaSelector(titulo: "Tipo producto", indiceSeleccionado: indiceTipo, opciones: CONSTANTES.PRODUCTO_TIPOS))
        
        // 3 - barcode
        data.listaItems.append(DMDCeldaCodigoBarras(codigoBarras: producto.propiedades?.codigoDeBarras ?? ""))
        
        
        // 4 - Talla
        var indiceTalla = 0
        if let propiedades = producto.propiedades {
            indiceTalla = CONSTANTES.TALLA.LISTADO.index(of: propiedades.talla!)!
        }
        data.listaItems.append(DMDCeldaSelector(titulo: "Talla", indiceSeleccionado: indiceTalla, opciones: CONSTANTES.TALLA.LISTADO))
        
        // 5 - Código de empresa
        data.listaItems.append(DMDCeldaLabel(nombre: "Código de empresa", texto: producto.propiedades?.codigoDeEmpresa ?? ""))
        
        // 6 - Precio coste
        let precioCoste = producto.propiedades?.precioCoste ?? 0.0
        data.listaItems.append(DMDCeldaLabel(nombre: "Precio coste", texto: "\(precioCoste)" ))
        
        // 7 - PVP
        let precioVentaPublico = producto.propiedades?.precioVentaPublico ?? 0.0
        data.listaItems.append(DMDCeldaLabel(nombre: "PVP", texto: "\(precioVentaPublico)"))
        
        // 8 - Descuento
        let descuento = producto.propiedades?.descuento ?? 0.0
        data.listaItems.append(DMDCeldaLabel(nombre: "Descuento", texto: "\(descuento)"))
        
        // 9 - IVA
        let IVA = producto.propiedades?.IVA ?? 0.0
        data.listaItems.append(DMDCeldaLabel(nombre: "IVA", texto: "\(IVA)"))
        
       
        
        
        //Permitir guardado
        data.guardar = true
        data.isBackButton = true
        
        return data
    }
}

