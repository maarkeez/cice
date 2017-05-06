//
//  ListaLugares.swift
//  App_IntroMapas
//
//  Created by cice on 24/2/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit

typealias diccionario = [String : String]
var customLugaresFavoritos = [diccionario]()
var indiceObjetoSeleccionado = -1

class ListaLugares: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customLugaresFavoritos.append(["name":"Taj - Mahal", "lat": "27.175277", "long":"78.04128"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customLugaresFavoritos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let dataModel = customLugaresFavoritos[indexPath.row]
        
        cell.textLabel?.text = dataModel["name"]
        cell.detailTextLabel?.text = dataModel["lat"]
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        indiceObjetoSeleccionado = indexPath.row
        return indexPath
    }
    
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "muestraMapaSinSeleccion" {
            indiceObjetoSeleccionado = -1
        }
     }
    
}
