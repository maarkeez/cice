//
//  DMDDetalleMejorado.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 25/1/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMDDetalleMejorado: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTableViewCustom: UITableView!



    override func viewDidLoad() {
        super.viewDidLoad()

        //Registro de la Celda que se reutilizará
        //myTableViewCustom.register(UITableViewCell.self, forCellReuseIdentifier: "CeldaCustom")
        
        //Indico que yo trataré los mensajes
        myTableViewCustom.delegate = self
        myTableViewCustom.dataSource = self
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


//MARK: - DELEGADOS
//Extendemos delegate y datasource para poder tratar los métodos de la tabla
extension DMDDetalleMejorado : UITableViewDelegate, UITableViewDataSource{
    
    //Implementamos la función que devuelve el número de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //Implementamos la función que devuelve el número de filas para la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // Implementamos la función que asigna un nombre para la sección
   /* func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return 1
    }*/
    
    //Implementamos la función que devuelve la celda a reutilizar
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //Creamos la celda que vamos a reutilizar
            //Debe tener el mismo nombre que el registro de la celda asignado en viewDidLoad()
          //  let cell = myTableViewCustom.dequeueReusableCell(withIdentifier: "CeldaCustom")!
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaCustom") as! DMDDetalleMejoradoCelda
        
        //Esconder separador
        cell.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, cell.bounds.size.width)
        
        cell.myDatoIzq.text = String(indexPath.row)
        cell.myDatoDerecha.text = String(indexPath.row)
        cell.mylblIzq.text = "Dato de la izquierda"
        cell.mylblDcha.text = "Dato de la derecha"
            //Devolvemos la celda creada
            return cell
        
        
    }
    
}
