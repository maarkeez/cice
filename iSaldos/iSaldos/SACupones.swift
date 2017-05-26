 //
//  SACupones.swift
//  iSaldos
//
//  Created by cice on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
import PromiseKit

class SACupones: UITableViewController {

    //MARK: - Variables locales
    var cupones  = [SAPromocionesModel]()
    var imagenSeleccionada : UIImage?
    //Diccionario para almacenar localmente las imágenes
    var diccionarioImagenes  = [String: UIImage?]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenu: UIBarButtonItem!
    
    //MARK: - IBActions
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        //Llamada para recuperar las ofertas
        llamadaCupones()
        
        //Mostrar el menú lateral
        mostrarMenu(myMenu)
        
        //Registro de la celda
        registroCelda()
        
    }

    
    //MARK: - Utils
    func llamadaCupones(){
        
        let datosOferta = SAParserPromociones()
        let idLocalidad = "11"
        let tipoOferta = CONSTANTES.LLAMADAS.OFERTA
        let tipoParametro = CONSTANTES.LLAMADAS.PROMOCIONES_SERVICE
        
        HUD.show(.progress)
        
        firstly {
            return when(resolved: datosOferta.getDatosPromociones(idLocalidad, idTipo: tipoOferta, idParametro: tipoParametro))
            
            }.then{_ in
                self.cupones = datosOferta.getParserPromociones()
            }.then{_ in
                self.tableView.reloadData()
            }.then{_ in
                HUD.hide(afterDelay: 0)
            }.catch{ error in
                self.present(muestraAlertVC("AQUI", messageData: "PROBLEMAS DE DESACARGA"), animated: true, completion: nil)
        }
        
        
        
    }
    
    func registroCelda(){
        tableView.register(UINib(nibName: "ISOfertaCustomCell", bundle: nil), forCellReuseIdentifier: "ISOfertaCustomCell")
    }
    
    // MARK: - Table view data source and delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cupones.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdaCupon = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        
        let cupon = cupones[indexPath.row]
        
        //Mostrar información que tenemos actualmente
        celdaCupon.myNombreOferta.text = cupon.nombre
        celdaCupon.myFechaOferta.text = cupon.fechaFin
        celdaCupon.myInformacionOferta.text = cupon.masInformacion
        celdaCupon.myImporteOferta.text = cupon.importe
        
        //Recuperar en background la imagen
        if var pathImagen = cupon.imagen {
            
            pathImagen = CONSTANTES.LLAMADAS.BASE_URL_FOTO + pathImagen
            
            let pathComplete = getImagePath(CONSTANTES.LLAMADAS.OFERTA, id: cupon.id!, name: cupon.imagen!)
            print("PATH_COMPLETO= \(pathComplete)")
            celdaCupon.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: pathComplete)!), placeholder: #imageLiteral(resourceName: "placeholder"), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
                //guardamos las imágenes en un diccionario
                self.diccionarioImagenes[cupon.id!] = image!
            })
            
        }
        
        return celdaCupon
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celda = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        imagenSeleccionada = celda.myImagenOferta.image
        
        performSegue(withIdentifier: "showCuponSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Comprobar que coincide con el segue para el detalle
        if segue.identifier == "showCuponSegue" {
            let detalleVC = segue.destination as! SACuponDetalle
            let indice = tableView.indexPathForSelectedRow?.row
            let cupon = cupones[indice!]
            //Asignar la oferta seleccionada
            detalleVC.cupon = cupon
            
            //Recuperar la imagen de la lista local
            detalleVC.detalleImagen = diccionarioImagenes[cupon.id!]!
        }
    }
    

}
