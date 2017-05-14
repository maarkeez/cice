//
//  DMDInventarioTabla.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 12/2/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDListadoEscaner: UITableViewController {

    //MARK: -  Variables locales
    var hashEscaneados = [String: Int]()
    
    //MARK: - IBOutlets
    
    //MARK: - IBActions
    
    @IBAction func guardarInventario(_ sender: Any) {
        
    }
    
    
    //MARK: - LIFE VC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Repintamos la tabla al acabar
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "Inventarios realizados"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "escanerSegue"){
            let escanerVC = segue.destination as! DMDEscanerQR
            escanerVC.delegate = self
            
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hashEscaneados.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdaInventario = tableView.dequeueReusableCell(withIdentifier: "DMDEscanerCelda", for: indexPath) as! DMDEscanerCelda
        
        let keys = [String](hashEscaneados.keys)
        let values = [Int](hashEscaneados.values)
        
        celdaInventario.myCantidad.text = "\(values[indexPath.row])"
        celdaInventario.myCodigoBarras.text = keys[indexPath.row]
        
        
        return celdaInventario
    }
}

//MARK: - Delegado para escaner
extension DMDListadoEscaner : DMDEscanerQRDelegate{
    
    ///Recupera los datos escaneados en la vista del escaner
    func getCodigosEscaneados(_ escanerQR: DMDEscanerQR, codigos: [String]) {
        
        //Recorremos cada codigo escaneado
        for codigo in codigos {
            if let cantidad = hashEscaneados[codigo]{
                //Aumenta en 1 si ya ha sido escaneado
                hashEscaneados[codigo] = cantidad + 1
            }else{
                //Inicializa a 1 si aun no existe
                hashEscaneados[codigo] = 1
            }
        }
        
        
    }

    
}
