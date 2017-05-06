//
//  DMDListadoContactosTVC.swift
//  solosView
//
//  Created by cice on 20/1/17.
//  Copyright © 2017 dmd. All rights reserved.
//

import UIKit



class DMDListadoContactosTVC: UITableViewController {
    
    //MARK: - Variables locales
    //typealias jsonStandar = [String : Any]
    var arrayDiccionario : [jsonStandar] = []
    var listadoContactos : jsonStandar = [:]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navigation  = self.navigationController as! HomeNavigationViewController
        navigation.botonPersonalizado.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let navigation  = self.navigationController as! HomeNavigationViewController
        navigation.botonPersonalizado.isHidden = true //ocultar el botón flotante del navigation padre
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let ruta = Bundle.main.path(forResource: "listadoContactos", ofType: "plist")
        arrayDiccionario = NSArray(contentsOfFile: ruta!) as! [jsonStandar]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //botón más flotante:
        let botonPersonalizado = UIButton(type: .custom)
        //Asignamos la imagen
        botonPersonalizado.setImage(UIImage(named:"button.jpg"), for: .normal )
        //Damos las medidas
        botonPersonalizado.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        //Redondeamos las esquinas
        botonPersonalizado.layer.cornerRadius = botonPersonalizado.frame.width / 2
        //Rellenamos el contenido con la imagen
        botonPersonalizado.imageView?.contentMode = .scaleToFill
        //Lo ajustamos
        botonPersonalizado.clipsToBounds = true
        //Lo asignamos al viewController cuando click
        botonPersonalizado.addTarget(self, action: #selector(self.showPerfil), for: .touchUpInside)
        
        //Creamos un botón para la barra de navegación
        let barButton = UIBarButtonItem(customView: botonPersonalizado)
        //Colocamos el botón en la barra de navegación
        navigationItem.rightBarButtonItem = barButton
        
        
    }
    
    func showPerfil() {
        let perfilVC = storyboard?.instantiateViewController(withIdentifier: "Perfil") as! DMDPerfilViewController
        
        
        navigationController?.pushViewController(perfilVC, animated: true)
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
        return arrayDiccionario.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath) as! DMDDetalleContactoTVCell
        
        listadoContactos = arrayDiccionario[indexPath.row]
        cell.nombre.text = listadoContactos["nombre"] as! String?
        cell.apellidos.text = listadoContactos["apellidos"] as! String?
        cell.fechaAlta.text = transformarFecha(fecha: listadoContactos["fechaAlta"] as! Date)
        cell.imagen.image = UIImage(named: listadoContactos["imagen"]! as! String)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalleContactoCompeltoVC = storyboard?.instantiateViewController(withIdentifier: "DetalleContactoCompelto") as! DMDDetalleContactoCompelto
        
        listadoContactos = arrayDiccionario[indexPath.row]
        detalleContactoCompeltoVC.listadoContactos = listadoContactos
        
        
        navigationController?.pushViewController(detalleContactoCompeltoVC, animated: true)
        
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
