//
//  SANasaNoticias.swift
//  iSaldos
//
//  Created by cice on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
import PromiseKit


class SANasaNoticias: UITableViewController {
    
    //MARK: - Variables locales
    var noticias = [SANasaModel]()
    var imagenSeleccionada : UIImage?
    //Diccionario para almacenar localmente las imágenes
    var diccionarioImagenes  = [String: UIImage?]()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenuBTN: UIBarButtonItem!
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarMenu(myMenuBTN)
        
        llamadaNasa()
        registroCelda()
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticias.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        
        let noticia = noticias[indexPath.row]
        
        //Mostrar información que tenemos actualmente
        celda.myNombreOferta.text = noticia.title
        celda.myFechaOferta.text = formatDate(noticia.fecha)
        celda.myInformacionOferta.text = noticia.explanation
        celda.myImporteOferta.text = ""
        
        //Recuperar en background la imagen
        if let pathImagen = noticia.url {
            
            
            
            print("PATH_COMPLETO= \(pathImagen)")
            
            celda.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: pathImagen)!), placeholder: #imageLiteral(resourceName: "placeholder"), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: { (image, error, cacheType, imageUrl) in
                //guardamos las imágenes en un diccionario
                if let imagenDes = image {
                    self.diccionarioImagenes[noticia.Id!] = imagenDes
                }
                
            })
            
        }
        
        return celda
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celda = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        imagenSeleccionada = celda.myImagenOferta.image
        
        performSegue(withIdentifier: "showNasaSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Comprobar que coincide con el segue para el detalle
        if segue.identifier == "showNasaSegue" {
            let detalleNoticia = segue.destination as! SANasaNoticiaDetalle
            let indice = tableView.indexPathForSelectedRow?.row
            let noticia = noticias[indice!]
            //Asignar la oferta seleccionada
            detalleNoticia.noticia = noticia
            
            //Recuperar la imagen de la lista local
            if let imagen =  diccionarioImagenes[noticia.Id!] {
                detalleNoticia.detalleImagen = imagen
            }
        }
    }
    
    //MARK: - Utils
    func llamadaNasa(){
        
        let datosNoticia = SAParserNasa()
        
        HUD.show(.progress)
        
        firstly {
            return when(resolved: datosNoticia.getDatosNasa())
            
            }.then{_ in
                self.noticias = datosNoticia.getParserPromociones()
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
