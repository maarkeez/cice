//
//  DMDCochesTableViewController.swift
//  AppTestTableView2
//
//  Created by cice on 13/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDCochesTableViewController: UITableViewController {
    
    var myArrayCoches : [DMDCocheModel] = []
    var myImageCoche = UIImage(named: "tesla.jpeg")
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Cambiar tamaño celda
        //self.tableView.rowHeight = 60.0
        
        //Inicializar el array en la carga de la ventana
        for index in 0..<23{
            let modelCoche = DMDCocheModel(nombre: "Nombre_\(index)", color: "Color_\(index)", imagenCoche: myImageCoche!)
            myArrayCoches.append(modelCoche)
            print("Coches \(myArrayCoches[index])")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myArrayCoches.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
        
        let cocheM = myArrayCoches[indexPath.row]
        
        cell.textLabel?.text = cocheM.nombre
        //Hay que cambiar el estilo a subtitle para la celda, para que muestre el color
        cell.detailTextLabel?.text = cocheM.color
        cell.imageView?.image = cocheM.imagenCoche
        
        return cell
    }
    
    //Metodo al seleccionar la celda
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("El coche seleccionado es \(myArrayCoches[indexPath.row].nombre)")
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
