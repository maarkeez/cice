//
//  ViewController.swift
//  AppTableViewIntro
//
//  Created by cice on 13/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Variables locales
    var myArrayMeses = ["Enero","Febrero","Marzo"]
    var myArrayMesesDos = ["Abril","Mayo","Junio"]
    
    //MARK: - IBOutlet
    @IBOutlet weak var myTableViewCustom: UITableView!
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registro de la Celda que se reutilizará
        myTableViewCustom.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //Indico que yo trataré los mensajes
        myTableViewCustom.delegate = self
        myTableViewCustom.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }


}

//MARK: - DELEGADOS
//Extendemos delegate y datasource para poder tratar los métodos de la tabla
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    //Implementamos la función que devuelve el número de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //Implementamos la función que devuelve el número de filas para la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myArrayMeses.count
        }else{
            return myArrayMesesDos.count
        }
    }
    
    // Implementamos la función que asigna un nombre para la sección
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Seccion 1"
        }else{
            return "Seccion 2"
        }
    }
    
    //Implementamos la función que devuelve la celda a reutilizar
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            //Creamos la celda que vamos a reutilizar
            //Debe tener el mismo nombre que el registro de la celda asignado en viewDidLoad()
            let cell = myTableViewCustom.dequeueReusableCell(withIdentifier: "Cell")!
            //Asginamos el texto de la celda
            cell.textLabel?.text = myArrayMeses[indexPath.row]
            //Devolvemos la celda creada
            return cell
        }else{
            //Creamos la celda que vamos a reutilizar
            //Debe tener el mismo nombre que el registro de la celda asignado en viewDidLoad()
            let cell = myTableViewCustom.dequeueReusableCell(withIdentifier: "Cell")!
            //Asginamos el texto de la celda
            cell.textLabel?.text = myArrayMesesDos[indexPath.row]
            //Devolvemos la celda creada
            return cell
        }
        
        
    }
    
}
