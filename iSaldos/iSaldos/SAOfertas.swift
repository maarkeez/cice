//
//  SAOfertas.swift
//  iSaldos
//
//  Created by David Márquez Delgado on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
import PromiseKit

class SAOfertas: UITableViewController {
    
    //MARK: - Variables locales
    var ofertas = [SAPromocionesModel]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenu: UIBarButtonItem!
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Llamada para recuperar las ofertas
        llamadaOferta()
        
        //Mostrar el menú lateral
        mostrarMenu(myMenu)
        
        //Registro de la celda
        registroCelda()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ofertas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdaOferta = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        
        let oferta = ofertas[indexPath.row]
        
        //Mostrar información que tenemos actualmente
        celdaOferta.myNombreOferta.text = oferta.nombre
        celdaOferta.myFechaOferta.text = oferta.fechaFin
        celdaOferta.myInformacionOferta.text = oferta.masInformacion
        celdaOferta.myImporteOferta.text = oferta.importe
        
        //Recuperar en background la imagen
        if var pathImagen = oferta.imagen {
            
            pathImagen = CONSTANTES.LLAMADAS.BASE_URL_FOTO + pathImagen
            
            let pathComplete = getImagePath(CONSTANTES.LLAMADAS.OFERTA, id: oferta.id!, name: oferta.imagen!)
            print("PATH_COMPLETO= \(pathComplete)")
            
            celdaOferta.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: pathComplete)!),
                                                   placeholder: #imageLiteral(resourceName: "placeholder"),
                                                   options: [.transition(ImageTransition.fade(1))],
                                                   progressBlock: nil,
                                                   completionHandler: nil)
        }
        
        
        return celdaOferta
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    //MARK: - Utils
    func llamadaOferta(){
        
        let datosOferta = SAParserPromociones()
        let idLocalidad = "11"
        let tipoOferta = CONSTANTES.LLAMADAS.OFERTA
        let tipoParametro = CONSTANTES.LLAMADAS.PROMOCIONES_SERVICE
        
        HUD.show(.progress)
        
        firstly {
            return when(resolved: datosOferta.getDatosPromociones(idLocalidad, idTipo: tipoOferta, idParametro: tipoParametro))
            
            }.then{_ in
                self.ofertas = datosOferta.getParserPromociones()
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
    
}












