//
//  DMDListaTareas.swift
//  App_BarLogin
//
//  Created by cice on 10/2/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit

class DMDListaTareas: UITableViewController {
    
    @IBAction func anadirTarea(_ sender: AnyObject) {
        let nuevaTareaVC = storyboard?.instantiateViewController(withIdentifier: "NuevaTarea") as! DMDNuevaTarea
        //Accedemos al navigationRoot de la ventana Nueva Tarea
        let navigationRoot = UINavigationController(rootViewController: nuevaTareaVC)
        
        present(navigationRoot, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Registramos la celda en la tabla
        tableView.register(UINib(nibName: "DMDDetalleTareaCelda", bundle: nil), forCellReuseIdentifier: "DetalleTareaCelda")
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
        return tareasManager.tareas.count
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetalleTareaCelda", for: indexPath) as! DMDDetalleTareaCelda

        let auxTexto = tareasManager.tareas[indexPath.row]
        let imagenData = tareasManager.fotoTarea[indexPath.row]
        
        let textoAux = auxTexto[CONSTANTES.USER_DEFAULTS.KEY_DESCRIPCION_TAREA] as! String?
        if let dataImagen = imagenData[CONSTANTES.USER_DEFAULTS.KEY_IMAGEN_TAREA] as? Data{
            
            if let icono = tareasManager.fotoTarea[indexPath.row][CONSTANTES.USER_DEFAULTS.KEY_ICONO_TAREA] {
                cell.setIBOutlets(texto: textoAux ,imagenFondo:  UIImage(data: dataImagen), imagenTarea: UIImage(named: icono as! String)! )
            }else{
                cell.setIBOutlets(texto: textoAux ,imagenFondo:  UIImage(data: dataImagen), imagenTarea: #imageLiteral(resourceName: "img_no_icon") )
            }
            
        }
        
       

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }

    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let borrarCelda = UITableViewRowAction(style: .normal, title: "\u{1F5D1}\n Borrar") { (action, indexPath) in
        tareasManager.tareas.remove(at: indexPath.row)
        tareasManager.fotoTarea.remove(at: indexPath.row)

        self.tableView.reloadData()
        }
        borrarCelda.backgroundColor = CONSTANTES.COLOR.AMARILLO
        
        let localizacion = UITableViewRowAction(style: .normal, title: "\u{267A}\n Localizacion") { (action, indexPath) in
            //action.backgroundColor = UIColor(patternImage:  UIImage(named: "icono_social")! )
        }

        let mas = UITableViewRowAction(style: .normal, title: "\u{1F601}\n Más opciones") { (action, indexPath) in
           
        }
        

        
        
        
        return [borrarCelda,localizacion,mas]
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listaIconos = self.storyboard?.instantiateViewController(withIdentifier : "ListaIconos") as! DMDListaIconos
       
        listaIconos.cabeceraDescripcionDeLaTarea = tareasManager.tareas[indexPath.row][CONSTANTES.USER_DEFAULTS.KEY_DESCRIPCION_TAREA] as! String?
        listaIconos.indiceTarea = indexPath.row
        self.present(listaIconos, animated: true, completion: nil)
        
        
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
