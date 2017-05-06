//
//  DMDListaContactosTableViewController.swift
//  AppTestTableViewMasterDetail
//
//  Created by cice on 13/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDListaContactosTableViewController: UITableViewController {
    
    // MARK : - Variables Locales
    var contactosArray : [[String : String]] = []   //Array de diccinarios vacío
    var contactosDiccionario : [String : String] = [:]  //Diccionario vacio
    
    // MARK : - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        //Recperamos el Diccionario Contactos.plist
        let rutaFichero = Bundle.main.path(forResource: "Contactos", ofType: "plist")
        //Rellenamos el array, debe ser tipo Array de dicionarios, por lo que se realiza el CAST
        contactosArray = NSArray(contentsOfFile: rutaFichero!) as! [[String : String]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    //Número de secciones disponibles
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    // Damos nombre a las secciones
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Familia"
        case 1:
            return "Universidad"
        default:
            return "Otros"
        }
    }
    
    //Recuperamos el número de lineas por seccion
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: Habría que implementar el tamaño en función del array que queramos
        return contactosArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: Habría que implementar el recuperar diccionarios diferentes en función de la sección.
        
        var cell : DMDContactosCustomCell
        //Obligamos a la celda a ser de mi tipo
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "Celda1", for: indexPath) as! DMDContactosCustomCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "Celda2", for: indexPath) as! DMDContactosCustomCell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "Celda3", for: indexPath) as! DMDContactosCustomCell
        }
       
        contactosDiccionario = contactosArray[indexPath.row]
        cell.Nombre.text = contactosDiccionario["nombre"]
        cell.Apellido.text = contactosDiccionario["apellido"]
        cell.Telefono.text = contactosDiccionario["telefono"]
        
        let imagenContactoAux = UIImage(named: contactosDiccionario["imagenContacto"]!)
        cell.ImagenContacto.image = imagenContactoAux
        
       // let imagentlfAux = UIImage(named: "phone.png")
        cell.imgTelefono.image = UIImage(named: "phone.png")
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ventanaDoscVC = self.storyboard?.instantiateViewController(withIdentifier: "DetalleViewController") as! DMDDetalleViewController
        //Envio el elemento seleccionado a la segunda vetnana
        ventanaDoscVC.detalleData = contactosArray[indexPath.row]

        //presento la vista
        self.navigationController?.pushViewController(ventanaDoscVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 125
        case 1:
            return 125

        default:
            return 204
        }
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
