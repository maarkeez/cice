 //
//  ListaPoster.swift
//  App_GaritosMadrid
//
//  Created by cice on 10/3/17.
//  Copyright © 2017 cice. All rights reserved.
//

 import UIKit
 import PromiseKit //Promesa de JSON
 import Kingfisher //Llamada asíncrona
 import PKHUD //Bloquear la llamada

class ListaPoster: UITableViewController {
    //MARK: - Variables locales
    var listaPoster = [Poster]()
    
    var listaNombrePersonajes = ["Batman","Superman","Jocker"]
    var listaPaginas = 1..<29
    var customRefresControl = UIRefreshControl()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myMenuBtn: UIBarButtonItem!
    @IBOutlet weak var myExtraBtn: UIBarButtonItem!
    
    //MARK: - LIFE VC
    deinit {
        print("Borro ListaPoster")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Refresh
        customRefresControl.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        customRefresControl.addTarget(self, action: #selector(self.refrescar), for: .valueChanged)
        
        tableView.addSubview(customRefresControl)
        
        //MARK: - Llamada
        getPoster()
        
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
        tableView.register(UINib(nibName: "DetallePoster", bundle: nil), forCellReuseIdentifier: "DetallePoster")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaPoster.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetallePoster", for: indexPath) as! DetallePoster
        
        cell.setIBOutlets(poster: listaPoster[indexPath.row])
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415
    }
    
    //MARK: - Utils
    func refrescar(){
        getPoster()
        customRefresControl.endRefreshing()
    }
    
    func getPoster(){
        
        let poster = GMParserPoster()
        
        let getIDpersonaje : Int = Int(arc4random_uniform(UInt32(listaNombrePersonajes.count)))
        var getpagina : Int = Int(arc4random_uniform(UInt32(listaPaginas.count)))
        
        if getpagina < 0 {
            getpagina = 0
        }
        
        //Bloqueo la pantalla del hilo principal
        HUD.show(.progress)
        
        //Inicialmente vas a ser la llamada datos a la URL
        //después haces el parseo
        //Luego recargas la tabla
        //Luego ocultas el hub
        //Luego tratas un error si lo hay
        firstly {
            return when(resolved: poster.getDataImdb("\(listaNombrePersonajes[getIDpersonaje])", page: "\(getpagina)" ))
            }.then { _ in
                self.listaPoster = poster.getParseImdb()
            }.then {_ in
                self.tableView.reloadData()
            }.then {_ in
                HUD.hide(afterDelay: 0)
            }.catch{ error in
                self.present(showAlert("Se ha producido un error", mensaje: "\(error.localizedDescription)", tituloAccion: "Cancelar carga"), animated: true, completion: nil)
        }
        
    }


}
