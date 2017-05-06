//
//  ListaFotos.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

import UIKit
import PromiseKit //Promesa de JSON
import Kingfisher //Llamada asíncrona
import PKHUD //Bloquear la llamada

class ListaFotos: UITableViewController {
    
    //MARK: - Variables locales
    var listaFotos = [Placeholder]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenuBtn: UIBarButtonItem!
    @IBOutlet weak var myExtraBtn: UIBarButtonItem!
    
    //MARK: - LIFE VC
    deinit {
        print("Borro ListaFotos")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Llamada
        getFotos()
        
        //MARK: - Menú lateral
        if revealViewController() != nil {
            myMenuBtn.target = revealViewController()
            myMenuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            
            myExtraBtn.target = revealViewController()
            myExtraBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //Registrar XIB de la celda
        tableView.register(UINib(nibName: "DetalleFoto", bundle: nil), forCellReuseIdentifier: "DetalleFoto")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaFotos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalleFoto", for: indexPath) as! DetalleFoto
        cell.setIBOutlets(foto: listaFotos[indexPath.row])
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415
    }
    
    //MARK: - Utils
    func getFotos(){
        
        let foto = GMParserPhotosData()
        
        //Bloqueo la pantalla del hilo principal
        HUD.show(.progress)
        
        //Inicialmente vas a ser la llamada datos a la URL
        //después haces el parseo
        //Luego recargas la tabla
        //Luego ocultas el hub
        //Luego tratas un error si lo hay
        firstly {
            return when(resolved: foto.getDatosPhotos())
            }.then { _ in
                self.listaFotos = foto.getParserPhotosDMD()
            }.then {_ in
                self.tableView.reloadData()
            }.then {_ in
                HUD.hide(afterDelay: 0)
            }.catch{ error in
                self.present(showAlert("Se ha producido un error", mensaje: "\(error.localizedDescription)", tituloAccion: "Cancelar carga"), animated: true, completion: nil)
        }
        
    }
    
}
